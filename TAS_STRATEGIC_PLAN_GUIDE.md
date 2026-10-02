# TAS Strategic Plan Page — Design Breakdown

Analysis of `tas_example_strategic_plan.html`, a full saved copy of
`https://www.tas.edu.tw/about/strategic-plan` (Taipei American School, built on **Finalsite**).
Use it as a reference for how a peer school structures a strategic plan page. For how to build
TYAS fragments, see `DESIGN_GUIDE.md`. §8 below covers carrying these patterns over.

> **Scope note:** this file is the *rendered page only*. The visual styling (colors, fonts,
> spacing, accordion chevrons, card backgrounds) lives in external Finalsite stylesheets
> (`/uploaded/themes/default_22/*.css`) that were **not** saved. Everything below describes
> structure, hierarchy and content design, plus the style hooks the markup exposes. It does not
> describe exact visual values.

---

## 1. Page anatomy

Unlike the TYAS fragments, this is a complete document. Only the `<main id="fsPageContent">` region
(lines ~776–3037) is page-specific. Everything else is site chrome shared across tas.edu.tw.

```
<head>            analytics (GTM, Meta Pixel), 6 theme stylesheets, :root feature flags
<body class="fsHasOneColumnLayout …">
  Skip-to-content link
  #fsMenu         overlay menu: search, utility nav, mobile nav, "Join Our School" CTA
  #fsHeader       logo, main nav (mega-menu), "In This Section" sub-nav,
                  breadcrumb, "Highlights" drawer (featured news post)
  <main>          ← page content (below)
  <footer>        social grid (Juicer feed), "More From TAS" post list, footer nav
```

### Main content, top to bottom

| # | Block | Finalsite element | Purpose |
|---|---|---|---|
| 1 | **Hero image** | `fsResourceElement … hero max-height` | Full-width banner photo (`StrategicPlanLandingHeader.jpg`), no text overlay. |
| 2 | **Intro** | `fsContent` | `h1` page title + two `h2` + four short paragraphs. |
| 3 | **Strategic plan accordion** | `fsPanelGroup fsAccordion accordion-style-alt` | Centered `h2` "WASC Strategic Action Plan", then **5 collapsible panels**, one per strategic area. |
| 4 | **PDF link** | `fsContent` with element title | "Click to View the PDF of the Strategic Action Plan" → "English Version" (flip-book link, new tab). |
| 5 | **Discover More** | `fsContainer content-card` + `fsThreeColumnLayout` | Centered heading, a pitch paragraph, and **three image buttons** (Community / Campus / Academics). |
| 6 | **Back to top** | `fsContent` | `#Top` anchor link. |

---

## 2. The core pattern: progressive disclosure

The page holds a lot of content (5 areas, 28 objectives, 2 years of progress reports) but shows
only 5 lines on first load. Everything is nested accordions, three levels deep:

```
Level 1  Accordion: Strategic Area N: <Name>                       (5 panels, alt style)
         └─ Area header: centered h2 <Name> + <hr />
         └─ Two-column: [Goal card (dark)] | [Rationale]
         └─ Two-column:
Level 2       [Accordion: objectives N.1–N.3] | [Accordion: objectives N.4–N.6]
         └─ Level 2  Accordion: "Progress on Area N"
                       └─ Panel "SY24–25"  → h3 area name, h5 themes, bullet lists
                       └─ Panel "SY25–26"  → same structure
```

Design choices worth noting:

- **Same template for every area.** Each area repeats header → goal/rationale → objectives →
  progress, so readers learn the layout once and can scan the rest.
- **Objectives are split across two side-by-side accordions** so a long list (up to 10 items in
  Area 5) becomes two short columns.
- **Progress is grouped by school year** (`SY24–25`, `SY25–26`). Each year is its own panel, which
  makes it easy to add a new year without disturbing older ones.
- **The outer accordion uses a variant** (`accordion-style-alt`). The top-level areas look
  different from the nested objective/progress accordions, which keeps the levels distinct.
- Accordion panel titles are the full objective statement with a number prefix and trailing colon
  (`1.2	Optimize Board Governance for Continuous School Improvement:`). The panel body is one
  paragraph expanding on it.

---

## 3. Strategic area template (detail)

```
┌──────────────────────── Strategic Area 1: A Strong Foundation ▾ ───────────────────────┐
│                         A Strong Foundation              (h2, centered)                 │
│ ─────────────────────────────────────────────────────── (hr)                            │
│ ┌─ content-card dark ─────────────┐   Rationale:        (h4, centered, bold)            │
│ │        Goal 1:     (h4 centered)│   One-paragraph justification of the goal.          │
│ │ To strengthen foundational …(h4)│                                                     │
│ │ Aligned to: WASC Category A …   │                                                     │
│ │      (italic small, fs_style_6) │                                                     │
│ └─────────────────────────────────┘                                                     │
│ ▸ 1.1 Ensure Strategic Direction…:      ▸ 1.4 Establish Systems to Enhance…:            │
│ ▸ 1.2 Optimize Board Governance…:       ▸ 1.5 Attract, Recruit, and Train…:             │
│ ▸ 1.3 Implement Consistent Structures…:                                                 │
│                                                                                         │
│ Progress on Area 1                                                                      │
│ ▸ SY24–25                                                                               │
│ ▸ SY25–26                                                                               │
└─────────────────────────────────────────────────────────────────────────────────────────┘
```

- **Goal card**: the only emphasized surface in the area. It uses a dark card (`content-card dark`)
  that contains a centered bold label "Goal N:", the goal sentence set in `h4`, and an
  italic "**Aligned to:** WASC Category X: …" line that ties each goal to the accreditation
  framework.
- **Rationale**: plain, unboxed, next to the card. It has the same `h4` centered bold label and one
  paragraph.
- **Variant (Area 5)**: there's no rationale column. The goal card spans the full width and is
  centered, and there's no progress section yet because it's a newly added pillar.

### Progress report body
```html
<h3>Strategic Area 1: A Strong Foundation</h3>
<h5><strong>Theme Name</strong></h5>
<ul>
  <li>Past-tense accomplishment, one sentence.</li>
  <li>…</li>
</ul>
<h5><strong>Next Theme</strong></h5>
…
```
Each year has 3–6 themes with about 2–4 bullets each. Bullets start with past-tense verbs
(*Revised, Introduced, Held, Launched, Implemented, Partnered, Engaged*) and name concrete
artifacts or partners (SkoolSpot, Stronge & Associates, Rosan Bosch Studios, "200+ stakeholders").

---

## 4. Typography hierarchy (as used in content)

| Level | Use on this page |
|---|---|
| `h1` | Page title "Our Strategic Action Plan", and "Discover More" (both wrapped in `fs_style_62`/`fs_style_89` spans, which are theme-defined text styles). |
| `h2` | Intro subsections, centered section/area headings, accordion panel titles. |
| `h3` | Area name at the top of each progress panel. |
| `h4` | "Goal N:" / "Rationale:" labels (centered, bold) and the goal statement. Also image-button titles. |
| `h5` | Theme headings inside progress reports, bolded with `<strong>`. |
| `p` | Body copy. Intro paragraphs run 2–4 sentences. |
| `fs_style_6` | Small italic "Aligned to" meta line. |
| `fs_style_65` | Lead paragraph style for the centered "Discover More" pitch. |
| `fs_style_68/69/72` | Button-style link ("English Version"). |
| `fs_style_80` | "Back to top" link style. |

Alignment rule: **section headings and labels are centered. Body text is left-aligned.** All
centering is done with inline `style="text-align: center;"` from the CMS editor.

Dividers: one `<hr />` under each area heading. That's the only rule line in the content.

---

## 5. Layout system

Finalsite builds every layout from a few primitives, which the markup exposes:

| Primitive | Classes | Used for |
|---|---|---|
| Page layout | `fsPageLayout fsOneColumnLayout` | The whole content area is one column (no sidebar). |
| Column layouts | `fsTwoColumnLayout`, `fsThreeColumnLayout` → `fsDiv fsStyleColumn fsStyleColumn-N [fsStyleColumn-last]` | Goal/Rationale, objectives split, image buttons. |
| Container | `fsContainer` (+ `content-card`) | Groups an element with a shared header (`fsElementHeaderContent`). |
| Element shell | `fsElement` > `header` (`fsElementTitle`) + `.fsElementContent` + `footer` (`fsElementFooterContent`) | Every block has the same title/body/footer slots. |
| Accordion | `fsPanelGroup fsAccordion fsPanelIconBefore` > `ul.fsTabsNav` + `section.fsPanel` | Collapsible groups. The icon sits before the title. |

Custom theme hooks added by TAS's designers: `hero max-height`, `content-card`, `dark`,
`accordion-style-alt`, `image-button small`.

---

## 6. Components

| Component | Markup hooks | Notes |
|---|---|---|
| Hero banner | `.hero.max-height` | Photo only, height-capped, no caption or overlay. |
| Goal card | `.content-card.dark` | Dark filled card that highlights the single most important statement in each area. |
| Accordion (primary) | `.fsAccordion.accordion-style-alt` | Top-level areas. Visually heavier variant. |
| Accordion (secondary) | `.fsAccordion` | Objectives and progress years. |
| Image button | `.image-button.small` in a 3-col layout | `h4` title + `figure.fsImage` + footer link. The whole tile works as a navigation card. |
| CTA band | `.content-card` container | Centered `h1` + lead paragraph above the image buttons. |
| Back-to-top | `#Top` anchor in the `h1` + link at the end | Useful because expanded accordions make the page very long. |

---

## 7. Content and voice

- **Framing first**: the intro explains *why* the plan exists (WASC re-accreditation, two-year
  self-study, "hundreds of data points") before showing any plan content.
- **Evolution is explicit**: the plan is described as living ("continued to evolve…introduced a
  fifth strategic pillar").
- **Area names are short aspirational noun phrases**: "A Strong Foundation", "An Enduring
  Commitment to Learning", "Culture of Safety and Belonging".
- **Goals use "To + verb…"** and objectives use imperative verbs (*Ensure, Optimize, Implement,
  Establish, Attract*).
- **Accountability language** shows up everywhere: SMART benchmarks, data dashboards, alignment to
  mission and schoolwide learning outcomes, WASC category mapping.
- **Close with a conversion step**: "Discover More" sends readers on to Community, Campus and
  Academics instead of ending on the plan.

---

## 8. Carrying these patterns into a TYAS fragment

TYAS pages are CMS fragments without Finalsite's JS or theme CSS (see `DESIGN_GUIDE.md`), so
rebuild the patterns natively rather than copying markup:

| TAS pattern | TYAS equivalent |
|---|---|
| `fsAccordion` panels | `<details class="xyz__panel"><summary>…</summary>…</details>`, which needs no JS. Style the `summary` marker yourself. |
| `accordion-style-alt` vs default | Two modifiers, e.g. `xyz__panel--area` (large, heading-sized summary with hairline) and `xyz__panel` (body-sized). |
| `content-card dark` goal card | `xyz__goal` using `--triadic2` as the background with light text, or keep the TYAS hairline style and mark it with the `--primary` accent. |
| Two-column Goal / Rationale | `xyz__intro-grid`-style `1fr 1fr` grid that collapses at 1024px. |
| Objectives split across two accordions | One list in a 2-col grid of `<details>`, collapsing to 1 column at 768px. |
| Progress by school year | Nested `<details>` per year, with `h5`-level theme labels styled like `__eyebrow` and plain `<ul>` lists. |
| Hero banner | `xyz__figure--wide xyz__hero` with the leaf corner. |
| Image buttons (Discover More) | 3-up cards like `__officers`, with the image + title wrapped in an `<a>`. |
| Inline `text-align: center` | Use classes. No inline styles. |
| `<hr />` under area headings | Hairline `border-bottom: 1px solid rgba(var(--info-rgb), 0.15)` on the heading. |

### Things not to copy
- The CMS cruft: `paraeid`/`paraid`/`lang` attributes pasted from Word, `&nbsp;` padding,
  empty `<p>&nbsp;</p>` spacers, and `<div class="notranslate" style="all: initial;">` stubs.
- The stray `<p><span class="fs_style_87">;</span></p>` under the accordion heading, which is a typo
  left in production.
- Empty `alt=""` on meaningful images (the image-button photos). Give them real alt text.
- A duplicated image in the "Our Academics" image button (two `figure.fsImage` with the same file).
- Inconsistent year labels: `SY24–25` (en dash) vs `SY25-26` (hyphen). Pick `&ndash;`.
- Stray whitespace in objective titles (tab after the number, double spaces mid-title, a leading
  space in " 5.5 HR Operations:").
