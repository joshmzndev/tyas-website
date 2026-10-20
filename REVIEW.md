# Review: items that need a person

These came out of the October 2026 refactor (see REFACTOR.md). Everything that could be fixed safely in the repo has been fixed. The list of fixes is at the end.

## Urgent

1. **Private files are publicly readable on the portal.** The old `deploy.sh` ran `scp -r *`, which uploaded every repo file. These currently return 200 at `https://portal.tyas.tyc.edu.tw/website/`: `CLAUDE.md`, `REFACTOR.md`, `deploy.sh` (it shows the `root@172.16.11.32` login and path) and `cms_stubs.html`. Once README.md and REVIEW.md exist they would be uploaded too. `deploy.sh` now uploads only the pages, `css/`, `images/` and `pdf/`, but the files already on the server must be **deleted by hand**. Also consider using a non-root deploy account.
2. **Re-deploy and update the CMS heights.** Every modern page's layout changed slightly, and safeguarding was rebuilt. After you run `./deploy.sh`, paste the new height lines from `cms_stubs.html` into the CMS stubs for accreditation, administration, mll, mun, safeguarding and strategic_plan. Old heights would cut off or pad the pages. The new safeguarding page is about 1.8× taller than before (4310px instead of 2410px on desktop).

## Content: needs school input

3. **MUN officer photos are missing (404):** `userfiles/images/article/mun/jonus.jpg`, `morris.jpg` and `vincent.jpg`. Upload them to the CMS, or send the files so they can go into `images/mun/`.
4. **Missing local photos:** eight administration staff have no file in `images/faculty/`: Sandy Chen, Sun Liu, Chloris Wu, Joyce Tseng, Michelle Yeon, Robin Liu, Kathy Lin and Tony Hsieh. They still display from the CMS. **Leo Lee** (administration) shows the `anon.jpg` placeholder and has no job title. `images/faculty/llee.jpg` exists locally but isn't on the CMS. Upload it (it's 7.7 MB, so resize it first) and supply a title.
5. **Photo swaps to confirm:** Adam Hsieh and Jessica Hung now use `people_photos/ahsieh.jpg` and `jhung.jpg`. Both were already uploaded to the CMS and match the local staging photos. Before this, Adam showed the placeholder and Jessica an older photo. Revert if that was intentional.
6. **Staff data to double-check:** Joyce Tseng's email is `finance@` (the same as Sandy Chen's). The names don't match the email or photo handles for Aline Zanetti (`apessoa`), Jeffrey Sebastian (`sreyesmelgar`), Sam Craiglee (`csam`) and Melody Ouyang (`houyang`). They may be correct.
7. **The MUN page uses the same photo twice:** `mun-1.jpg` is both the hero image and the first WJMUN photo. A different hero image would help.
8. **Strategic plan wording** is quoted from the school's plan, so it was left as is. Some of it needs fixing:
   - The plan says "CIS/WASC" and "Western Association of Schools and Colleges (WASC)", but the site standard is "ACS WASC and CIS". Its "Dual Accreditation" and "Achieve CIS/WASC accreditation" read as goals, which is correct, but please confirm.
   - In 3.1, "schoolwide experiences of multilingual learners for the multilingual learners" is garbled.
   - In 1.3, the sentence ending "…and committed to TYAS's mission…" is garbled.
   - 2.5 starts with "Strengthening", but the other objectives start with an imperative ("Strengthen").
   - Roadmap "Year 5 · 2029" probably should be "2028–2029".
   - The subtitle was changed to "…and the ACS WASC and CIS Accreditation Process", so it no longer implies the school is accredited.
9. **Live safeguarding page** still shows Strategic Plan text. Point it at `safeguarding.html` with the stub.

## Design decisions

10. **Two title styles.** Accreditation and Strategic Plan use a centered title and italic subtitle. The other pages use eyebrow + two-line left-aligned heading. Both are now documented. Converting acc/stp to the main style would make every page consistent; say if you want it.
11. **Strategic plan button** (`.stp__button`) has a 2px blue border, which breaks the "1px hairlines only" rule. It was kept because a hairline makes a weak call to action. The goal boxes lost their grey fill and 3px top border; they now use hairlines.
12. **MLL logo frames** (`.mll__diagram`, `.mll__credit-logo`, `.mll__research-logo`) are white boxes with a rounded corner. They're borderline under "no rounded boxes", but they stop the logos from floating on the page. They were kept.
13. **Staff pages (administration, faculty)** still use the copied live-site CSS, with hex greys and repeated IDs (`#articleInfo16`, `#AB001`…). These are left alone so they match the rest of the CMS. Rebuilding them on the modern design is a separate project.
14. **Faculty tabs** are `<a onclick>` with no `href`, so keyboard users can't reach them, and there's no "active tab" state. A small fix would be `href="#boxN" target="_self"` plus `return false`, and an active class.
15. **Staging photos in `images/faculty/`** (about 24 MB; `ahsieh.jpg` and `llee.jpg` are over 6 MB) get deployed but no page uses them. Consider moving them out of `images/`, e.g. to `photos_to_upload/`. Also delete the stray `images/faculty/.claude/` folder (old local tool settings). The automated session wasn't allowed to delete it.

## Fixed in this pass

- `deploy.sh` now uploads only the hosted files.
- **People pages:**
  - Michelle Yeon's email link went to `crand@`; it now goes to `myeon@`.
  - Fixed the `mailto: finance@` link (it had a space).
  - Removed stray spaces and `&nbsp;` around emails and a stray `<br />` before Sun Liu's photo.
  - Hui-Ya Chang's photo was a 404 (`.jpeg` instead of `.jpg`).
  - "Matt ZUHL" is now "Matt Zuhl".
  - Every staff photo now has `alt` text.
- **MUN:**
  - `strong` text rendered at 16px inside larger paragraphs.
  - The first officer photo kept a 130px corner on phones.
  - Hover zoom was 1.04 instead of 1.03.
  - Removed a dead `--featured` rule.
  - Renamed `#mun_section` to `#mun_wjmun`.
  - Wording: added the first TYAS mention, expanded "NGOs", and fixed "Japan, and Korea" and "first ever".
- **Strategic plan:**
  - Objective titles rendered at 16px.
  - Descriptions were grey instead of body blue.
  - Fixed off-scale sizes (13px, 19px, 28px).
  - Section comments were numbered in the wrong order.
- **MLL:** fixed off-scale sizes (17px, 2px gaps, 2px letter spacing) and the heading margin. Added the first TYAS mention.
- **Accreditation:** removed an unused placeholder class, used the lead text size, and added the first TYAS mention and the ACS WASC expansion.
- **Safeguarding:** rebuilt on the shared design. The text is unchanged apart from TYAS naming.
- **All CSS:**
  - Changed the `'Crimson Text', sans-serif` fallback to `serif`.
  - Replaced `#fff` with `var(--white)`.
  - The body text on acc and stp now uses the standard lead size.
- **Docs:**
  - Shortened CLAUDE.md and added README.md.
  - Re-measured `cms_stubs.html` heights with the new `tools/measure_heights.sh`. The administration phone height was 90px short.
