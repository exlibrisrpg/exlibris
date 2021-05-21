namespace :import do
  desc "Import a JSON formatted list of entries"
  task json: :environment do |t, args|
    require "open-uri"

    ARGV.each do |a|
      task a.to_sym {}
    end

    json_path = ARGV[1]
    category = ARGV[2]
    json_file = File.open(json_path)
    json_data = JSON.parse(File.read(json_file), symbolize_names: true)

    entry_builder = Class.new do
      def initialize(category_name)
        @creator_tag_category = TagCategory.find_by!(name: "Creators")
        @category_tag_category = TagCategory.find_by!(name: "Categories")
        @category_tag = Tag.find_or_create_by!(name: category_name, tag_category: @category_tag_category)
      end

      def build_entry(entry_json)
        entry = Entry.with_includes.find_or_initialize_by(name: entry_json[:name])

        if entry_json[:url].present?
          entry.links.find_or_initialize_by(address: entry_json[:url])
        end

        if entry_json[:img_url].present? && !entry.cover.attached?
          response = Net::HTTP.get_response(URI.parse(entry_json[:img_url]))
          image_file = StringIO.new(response.body)
          cleaned_url = URI.parse(entry_json[:img_url])
          cleaned_url.query = nil
          filename = cleaned_url.path.split("/").last
          content_type = case filename.split(".").last
                 when "png"
                   "image/png"
                 when "jpg", "jpeg"
                   "image/jpg"
                 else
                   raise "Unknown filetype"
          end

          entry.cover.attach(io: image_file, filename: filename, content_type: content_type)
        end

        if entry_json[:description].present?
          entry.description = entry_json[:description]
        end

        if entry_json[:creators].present?
          entry_json[:creators].each do |creator|
            creator_tag = Tag.find_or_create_by!(name: creator, tag_category: @creator_tag_category)
            entry.tags << creator_tag unless entry.tags.include?(creator_tag)
          end
        end

        entry.save
        entry.tags << @category_tag unless entry.tags.include?(@category_tag)
      end
    end

    builder = entry_builder.new(category)

    json_data.each.with_index do |entry_json, index|
      puts "Importing #{index + 1} of #{json_data.count}"
      builder.build_entry(entry_json)
    end
  end
end
