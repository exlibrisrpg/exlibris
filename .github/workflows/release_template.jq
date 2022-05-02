.release |
{
  embeds: [
    {
      type: "rich",
      title: .name,
      description: .body,
      color: 4037200,
      fields: [
        {
          name: "Tag",
          value: .tag_name,
          inline: true
        }
      ],
      timestamp: .published_at,
      author: {
        name: "exlibrisrpg/exlibris",
        url: "https://github.com/exlibrisrpg/exlibris"
      },
      url: .html_url
    }
  ],
  username: .name
}
