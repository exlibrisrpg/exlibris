require "test_helper"

class MetaTagsComponentTest < ViewComponent::TestCase
  context "with no target" do
    should "render correct meta tags" do
      expected_html = <<~HTML
        <title>Ex Libris Mörk Borg</title>
        <meta name="description" content="A directory of content, tools, and resources">
        <link rel="canonical" href="http://test.host/">
        <link rel="image_src" href="http://test.host/assets/exlibris_yellow_social-2938feefb998a76e38fd51927fd1fc5cc7631b4e9eeed6d5a045ba3b3f40b16d.jpg">
        <meta property="og:title" content="Ex Libris Mörk Borg">
        <meta property="og:description" content="A directory of content, tools, and resources">
        <meta property="og:site_name" content="Ex Libris Mörk Borg">
        <meta property="og:image" content="http://test.host/assets/exlibris_yellow_social-2938feefb998a76e38fd51927fd1fc5cc7631b4e9eeed6d5a045ba3b3f40b16d.jpg">
        <meta property="og:url" content="http://test.host/">
        <meta name="twitter:card" content="summary_large_image">
      HTML

      assert_equal(
        expected_html,
        render_inline(MetaTagsComponent.new(target: nil)).to_html
      )
    end
  end

  context "with no target and a title" do
    should "render correct meta tags" do
      expected_html = <<~HTML
        <title>About | Ex Libris Mörk Borg</title>
        <meta name="description" content="A directory of content, tools, and resources">
        <link rel="canonical" href="http://test.host/about">
        <link rel="image_src" href="http://test.host/assets/exlibris_yellow_social-2938feefb998a76e38fd51927fd1fc5cc7631b4e9eeed6d5a045ba3b3f40b16d.jpg">
        <meta property="og:title" content="About">
        <meta property="og:description" content="A directory of content, tools, and resources">
        <meta property="og:site_name" content="Ex Libris Mörk Borg">
        <meta property="og:image" content="http://test.host/assets/exlibris_yellow_social-2938feefb998a76e38fd51927fd1fc5cc7631b4e9eeed6d5a045ba3b3f40b16d.jpg">
        <meta property="og:url" content="http://test.host/about">
        <meta name="twitter:card" content="summary_large_image">
      HTML

      assert_equal(
        expected_html,
        render_inline(MetaTagsComponent.new(target: nil, title: "About", url: "http://test.host/about")).to_html
      )
    end
  end

  context "with an entry without a cover" do
    should "render correct meta tags" do
      entry = Entry.create(
        name: "Eat, Prey, Kill",
        description: "A <strong>vile</strong> and <em>evil</em> thought.",
        system: systems(:mork_borg)
      )

      expected_html = <<~HTML
        <title>Eat, Prey, Kill | Ex Libris Mörk Borg</title>
        <meta name="description" content="A vile and evil thought.">
        <link rel="canonical" href="http://test.host/entries/eat-prey-kill">
        <link rel="image_src" href="http://test.host/assets/exlibris_yellow_social-2938feefb998a76e38fd51927fd1fc5cc7631b4e9eeed6d5a045ba3b3f40b16d.jpg">
        <meta property="og:title" content="Eat, Prey, Kill">
        <meta property="og:description" content="A vile and evil thought.">
        <meta property="og:site_name" content="Ex Libris Mörk Borg">
        <meta property="og:image" content="http://test.host/assets/exlibris_yellow_social-2938feefb998a76e38fd51927fd1fc5cc7631b4e9eeed6d5a045ba3b3f40b16d.jpg">
        <meta property="og:url" content="http://test.host/entries/#{entry.to_param}">
        <meta name="twitter:card" content="summary_large_image">
      HTML

      assert_equal(
        expected_html,
        render_inline(MetaTagsComponent.new(target: entry)).to_html
      )
    end
  end

  context "with an entry with a cover" do
    should "render correct meta tags" do
      ActiveStorage::Current.set(url_options: {host: "http://example.com"}) do
        entry = Entry.create(
          name: "Eat, Prey, Kill",
          description: "A <strong>vile</strong> and <em>evil</em> thought.",
          system: systems(:mork_borg)
        )
        entry.cover.attach(io: File.open("test/fixtures/files/eatpreykill.png"), filename: "eatpreykill.png", content_type: "image/png")

        expected_html = <<~HTML
          <title>Eat, Prey, Kill | Ex Libris Mörk Borg</title>
          <meta name="description" content="A vile and evil thought.">
          <link rel="canonical" href="http://test.host/entries/eat-prey-kill">
          <link rel="image_src" href="#{entry.cover.url}">
          <meta property="og:title" content="Eat, Prey, Kill">
          <meta property="og:description" content="A vile and evil thought.">
          <meta property="og:site_name" content="Ex Libris Mörk Borg">
          <meta property="og:image" content="#{entry.cover.url}">
          <meta property="og:url" content="http://test.host/entries/#{entry.to_param}">
          <meta name="twitter:card" content="summary_large_image">
        HTML

        assert_equal(
          expected_html,
          render_inline(MetaTagsComponent.new(target: entry)).to_html
        )
      end
    end
  end

  context "with a tag" do
    should "render correct meta tags" do
      tag_category = tag_categories(:mork_borg_categories)
      tag = Tag.create(
        name: "Alternative Rules",
        short_description: "Play by them, you fool",
        description: "All the <strong>awful</strong> ways you could die.",
        tag_category: tag_category,
        system: tag_category.system
      )

      expected_html = <<~HTML
        <title>Alternative Rules | Ex Libris Mörk Borg</title>
        <meta name="description" content="All the awful ways you could die.">
        <link rel="canonical" href="http://test.host/tags/alternative-rules">
        <link rel="image_src" href="http://test.host/assets/exlibris_yellow_social-2938feefb998a76e38fd51927fd1fc5cc7631b4e9eeed6d5a045ba3b3f40b16d.jpg">
        <meta property="og:title" content="Alternative Rules">
        <meta property="og:description" content="All the awful ways you could die.">
        <meta property="og:site_name" content="Ex Libris Mörk Borg">
        <meta property="og:image" content="http://test.host/assets/exlibris_yellow_social-2938feefb998a76e38fd51927fd1fc5cc7631b4e9eeed6d5a045ba3b3f40b16d.jpg">
        <meta property="og:url" content="http://test.host/tags/alternative-rules">
        <meta name="twitter:card" content="summary_large_image">
      HTML

      assert_equal(
        expected_html,
        render_inline(MetaTagsComponent.new(target: tag)).to_html
      )
    end
  end
end
