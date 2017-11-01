---
layout: archive
title: Posts by Categories
permalink: /categories/
sidebar:
  nav: 'docs'
---
This page displays the site's categories in alphabetical order and shows how many posts there are per tag, makes anchor links for each tag, then outputs posts by tag in reverse chronological order. 

### Posts by categories

{% assign sorted_cat = (site.categories | sort:0) %}
<ul class="cat-box">
	{% for cat in sorted_cat %}
		{% assign t = cat | first %}
		{% assign posts = cat | last %}
		<li><a href="#{{ t | downcase }}">{{ t }} <span class="size">({{ posts.size }})</span></a></li>
	{% endfor %}
</ul>

{% for cat in sorted_cat %}
  {% assign t = cat | first %}
  {% assign posts = cat | last %}

<h4 id="{{ t | downcase }}">{{ t }}</h4>
<ul>
{% for post in posts %}
  {% if post.categories contains t %}
    <li>
       <span class="date">{{ post.date | date: '%d %b %y' }}</span>:  <a href="{{ post.url }}">{{ post.title }}</a>
    </li>
  {% endif %}
{% endfor %}
</ul>
{% endfor %}

<!-- Listing posts by categorie template from http://github.com/cagrimmett/jekyll-tools -->
