---
title:  "Blog"
layout: archive
permalink: /blog/
author_profile: true
comments: true
sidebar:
  nav: 'docs'
---

Below you may find all posts I wrote, some were previously hosted at a wordpress blog so the layout of the code snippet might be weird. I will try to work down the posts and fix this.

Feel free to leave comments, also I am always happy to hear about posts ideas.

{% for post in site.posts %}
  {% include archive-single.html %}
{% endfor %}
