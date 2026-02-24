# Format Links Collection

Convert raw links dump into formatted markdown for `/src/pages/links/`.

## Usage
Paste raw links (Craft export, plain text, URLs with quotes) and specify the period (e.g., "Nov & Dec '25").

## Process

### 1. Generate frontmatter
```yaml
---
layout: ../../layouts/LinkLayout.astro
title: [Mon] & [Mon] '[YY]
date: YYYY-MM-DD  # last day of period
featuredImage: /images/links/YYMMDD/[TBD].webp
caption: "[TBD]"
---
```

### 2. For each link
- Clean URL (strip `utm_*`, `?ref=`, tracking params)
- Generate numbered entry with lowercase title
- Convert quotes to `>` blockquotes (4-space indent)
- Use `<img>` tags, NOT `![]()`
- End entries with period

### 3. Flag for manual attention
- **Paywalled**: economist.com, nytimes.com, unherd.com, ft.com → needs archive.ph
- **Twitter/X links**: needs context lookup (can't scrape)
- **Garbage titles**: "Attention Required! | Cloudflare" → needs rewrite
- **Images**: raw `Image.png` / `Image.tiff` → needs renaming

### 4. Output
- Draft to `/src/pages/links/YYMMDD.md`
- List images needed in `/public/images/links/YYMMDD/`
- If images missing, just notify user
- List URLs needing archiving
- List Twitter links needing context

## Formatting rules
- `<img src="..." alt="..." class="small-image">` for images
- Distribute images every 4-6 entries
- Videos: prefix with "Video:"
- Book reviews: "Book Review: [Title]"
- Merge links if possible: "Topic A and [topic B](url)"

## What stays manual
- Ordering
- Title rewrites  
- Quote selection/trimming
- Editorial commentary
- Featured image + caption
- Twitter context
- Image filenames