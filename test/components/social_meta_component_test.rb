require "test_helper"

class SocialMetaComponentTest < ViewComponent::TestCase
  context "with no target" do
    should "render correct meta tags" do
      expected_html = <<~HTML
        <meta property="og:title" content="Ex Libris Mörk Borg">
        <meta property="og:site_name" content="Ex Libris Mörk Borg">
        <meta property="og:description" content="A directory of content, tools, and resources">
        <meta property="og:image" content="http://test.host/packs-test/media/images/potato_borg-b382c541d9a1044451f37d00d25b043a.png">
        <meta property="og:url" content="http://test.host/">
        <meta name="twitter:card" content="summary_large_image">
      HTML

      assert_equal(
        expected_html,
        render_inline(SocialMetaComponent.new(target: nil)).to_html
      )
    end
  end

  context "with no target and a title" do
    should "render correct meta tags" do
      expected_html = <<~HTML
        <meta property="og:title" content="About | Ex Libris Mörk Borg">
        <meta property="og:site_name" content="Ex Libris Mörk Borg">
        <meta property="og:description" content="A directory of content, tools, and resources">
        <meta property="og:image" content="http://test.host/packs-test/media/images/potato_borg-b382c541d9a1044451f37d00d25b043a.png">
        <meta property="og:url" content="http://test.host/about">
        <meta name="twitter:card" content="summary_large_image">
      HTML

      assert_equal(
        expected_html,
        render_inline(SocialMetaComponent.new(target: nil, title: "About", url: "http://test.host/about")).to_html
      )
    end
  end

  context "with an entry without a cover" do
    should "render correct meta tags" do
      entry = Entry.create(
        name: "Eat, Prey, Kill",
        description: "A <strong>vile</strong> and <em>evil</em> thought."
      )

      expected_html = <<~HTML
        <meta property="og:title" content="Eat, Prey, Kill | Ex Libris Mörk Borg">
        <meta property="og:site_name" content="Ex Libris Mörk Borg">
        <meta property="og:description" content="A vile and evil thought.">
        <meta property="og:image" content="http://test.host/packs-test/media/images/potato_borg-b382c541d9a1044451f37d00d25b043a.png">
        <meta property="og:url" content="http://test.host/entries/#{entry.id}">
        <meta name="twitter:card" content="summary_large_image">
      HTML

      assert_equal(
        expected_html,
        render_inline(SocialMetaComponent.new(target: entry)).to_html
      )
    end
  end

  context "with an entry with a cover" do
    should "render correct meta tags" do
      ActiveStorage::Current.set(host: "http://example.com") do
        entry = Entry.create(
          name: "Eat, Prey, Kill",
          description: "A <strong>vile</strong> and <em>evil</em> thought."
        )
        entry.cover.attach(io: File.open("test/fixtures/files/eatpreykill.png"), filename: "eatpreykill.png", content_type: "image/png")

        expected_html = <<~HTML
          <meta property="og:title" content="Eat, Prey, Kill | Ex Libris Mörk Borg">
          <meta property="og:site_name" content="Ex Libris Mörk Borg">
          <meta property="og:description" content="A vile and evil thought.">
          <meta property="og:image" content="#{entry.cover.url}">
          <meta property="og:url" content="http://test.host/entries/#{entry.id}">
          <meta name="twitter:card" content="summary_large_image">
        HTML

        assert_equal(
          expected_html,
          render_inline(SocialMetaComponent.new(target: entry)).to_html
        )
      end
    end
  end

  context "with a tag" do
    should "render correct meta tags" do
      tag = Tag.create(
        name: "Rules",
        short_description: "Play by them, you fool",
        description: "All the <strong>awful</strong> ways you could die.",
        tag_category: tag_categories(:categories)
      )

      expected_html = <<~HTML
        <meta property="og:title" content="Rules | Ex Libris Mörk Borg">
        <meta property="og:site_name" content="Ex Libris Mörk Borg">
        <meta property="og:description" content="All the awful ways you could die.">
        <meta property="og:image" content="http://test.host/packs-test/media/images/potato_borg-b382c541d9a1044451f37d00d25b043a.png">
        <meta property="og:url" content="http://test.host/tags/#{tag.id}">
        <meta name="twitter:card" content="summary_large_image">
      HTML

      assert_equal(
        expected_html,
        render_inline(SocialMetaComponent.new(target: tag)).to_html
      )
    end
  end
end
