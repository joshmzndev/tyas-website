# TYAS website pages

Standalone content pages for https://www.tyas.tyc.edu.tw, hosted at `https://portal.tyas.tyc.edu.tw/website/<page>.html` and shown in the CMS through an iframe stub. README.md is the human guide; this file holds the rules.

## Hard constraints
- The CMS strips `<script>` but keeps `<style>`, inline `style=""` and `<iframe>`. The stub can't run JS, so don't propose auto-resize or fetch-and-inject. JS inside hosted pages is fine (`showStoreInfo()` in `faculty.html`).
- Site CSS doesn't reach into the iframe. `css/tyas.css` is the only stylesheet. Other site classes (`col_*`, `d_flex`, `.more_btn`, Bootstrap, Font Awesome) don't exist. Add a rule to `tyas.css` before you use a new class.
- `cms_stubs.html` holds the stub template and one height line per page (`--h1`…`--h7`). After a layout or content change, run `tools/measure_heights.sh <page>...` and paste the output into the stub. Keep `scrolling="auto"`. The credit line must stay visible.
- `deploy.sh` uploads only the root `*.html` files (except `cms_stubs.html`), `css/`, `images/` and `pdf/`. Keep docs and tools out of those folders.

## Files
- Modern templates: `accreditation.html` (`acc__`), `mll.html` (`mll__`), `mun.html` (`mun__`), `safeguarding.html` (`sfg__`), `strategic_plan.html` (`stp__`). `acc` and `stp` use a centered title/subtitle variant. The others use eyebrow + two-line `h2`.
- Legacy CMS staff layouts: `administration.html`, `faculty.html` (`#articleInfo16` cards, repeated IDs, CMS-hosted photos in `/userfiles/images/article/people_photos/`). Their CSS block is copied from the live site and keeps its hex colours on purpose.
- `images/<prefix>/` for new images (relative paths). `images/faculty/` is a staging set for CMS uploads and isn't referenced by any page. It has one file per person, named first initial + last name in lowercase (`jsebastian.jpg`, `hkan.jpg`), `.jpg` or `.png`; CMS filenames may differ. `pdf/` is embedded via `<iframe src="pdf/...">`.

## Page rules
- Skeleton: `<!DOCTYPE html>`, then `<head>` with charset, viewport, `<title>Name | Taoyuan American School</title>`, `<base target="_top" />` and `<link href="css/tyas.css" rel="stylesheet" />`. No `<style>` or `style=""` in pages.
- In-page anchors need `target="_self"`.
- Structure: `<!-- ===== SECTION N: NAME ===== -->` → `section#prefix_name > .workframe > .wrapper` → eyebrow → two-line `h2` (`<br />`) → content. Use `<article>` for repeated cards, `<figure>` for images and `<details>/<summary>` for accordions.
- Naming: IDs `prefix_name`, classes `prefix__part` / `prefix__part--modifier`. Scope every rule to its prefix and never restyle bare elements.
- Markup: `<br />`, `<img ... />`, alphabetical attributes, entities (`&#39; &quot; &ndash; &middot; &amp;`), a blank line between blocks, and only `<li>` tab-indented. Always write descriptive `alt` text.
- CSS block per page: `/* ---- Shared ---- */` → per-section → `/* ---- Responsive ---- */` (`@media (max-width: 1024px | 768px | 640px)`, desktop-first).

## Design tokens
- Colours (variables only): `--triadic2` headings/strong, `--triadic1` body, `--primary` accents/underlines, `--complement` small labels, `--secondary` rare big red, `--info` default, `--white`. Hairlines and muted text use `rgba(var(--info-rgb), .15 | .5)`. Other `--*-rgb` values are wrong; don't use them.
- The reset forces Crimson Text 16px `--info` on `div p li a span strong h2-h6…`, so nothing inherits. Set font, size and colour on every text class, and give `strong` inside larger text `font-size: inherit; line-height: inherit`. `h1` isn't reset. Lists have no bullets.
- Font stack: `'Crimson Text', serif` (Noto Sans TC for Chinese).
- Type: eyebrow 14px/600/oblique/uppercase/ls 3px `--complement` · `h2` `clamp(46px,5vw,72px)` 600 uppercase lh 110% mb 48 `--triadic2` · card title 28px or `clamp(32px,3vw,46px)` 600 · lead `clamp(20px,1.6vw,26px)` lh 170% ls .5px max-width 720 `--triadic1` · card body 18px lh 160–165% · caption 15px 600 oblique uppercase muted. `strong` in lead text: 700, `--triadic2`, 2px `--primary` underline at offset 4px.
- Spacing only 4 6 8 10 12 16 20 24 32 40 48 56 80. Section padding `6vw 0`; card grid gap 40, two-column gap 80, card padding 48.
- Flat: no shadows, fills or rounded boxes; lines are 1px hairlines only. Images get leaf corners (`0 0 130px 0`, `130px 0 0 0`, `130px 0 130px 0`), alternating between neighbours, 60px at ≤640. Figures: `overflow:hidden; margin:0`, aspect-ratio wide 16/7 (4/3 mobile), pair 4/3, portrait 3/4; hover `scale(1.03)` over .6s.

## Content rules
- Write "Taoyuan American School (TYAS)" on first mention, "TYAS" after. Expand each acronym once. Use `<strong>` for proper nouns/achievements and `<em>` for quoted themes. Voice: formal and warm.
- Accreditation: candidacy with **ACS WASC and CIS**, which is not full accreditation. Never "accredited" or "CIS member".
- Contact: phone +886-3-341-1890, fax +886-3-215-1079. Application page `/article-Process.html`.
- Open issues and decisions are in REVIEW.md.
