# Review: items that need a person

These came out of the October 2026 refactor passes (see REFACTOR.md). Everything that could be fixed safely in the repo has been fixed; the latest pass's fixes are listed at the end, and earlier ones are in git history.

## Urgent

1. **Private files are publicly readable on the portal.** The old `deploy.sh` ran `scp -r *`, which uploaded every repo file. These currently return 200 at `https://portal.tyas.tyc.edu.tw/website/`: `CLAUDE.md`, `REFACTOR.md`, `deploy.sh` (it shows the `root@172.16.11.32` login and path) and `cms_stubs.html`. Once README.md and REVIEW.md exist they would be uploaded too. `make deploy` now uploads only the pages, `css/`, `images/` and `pdf/`, but the files already on the server must be **deleted by hand**. Also consider using a non-root deploy account.
2. **Re-deploy and update the CMS heights.** Every modern page changed height, mostly on phones (headings now shrink to fit), and MUN lost its officer photos. After you run `make deploy`, paste the new height lines from `cms_stubs.html` into the CMS stubs for accreditation, administration, faculty, mll, mun, safeguarding and strategic_plan. Faculty no longer uses tabs or the 85vh scrolling window; it is one long list with a search box, so its stub needs the new pixel heights. Administration got the same search box. Old heights would cut off or pad the pages. Safeguarding is about 9090px tall on desktop (the live page was 4310px).
3. **A local settings file may be on the server.** Earlier deploys copied all of `images/`, including the hidden `images/faculty/.claude/settings.local.json` (old AI-tool settings that show local usernames and paths). The local copies are deleted; remove `website/images/faculty/.claude/` from the server if it's there.

## Content: needs school input

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
9. **Safeguarding page.** The live page still shows Strategic Plan text. Point it at `safeguarding.html` with the stub. The page was rebuilt from the Phase 1 copy and the 2026–2027 Child Safeguarding Policy (sources are in `_originals/safeguarding/`). Please confirm:
   - **Team photos** come from the `images/faculty/` staging set, copied to `images/safeguarding/` and resized to 800px wide (`elin`, `crand`, `mschen`, `jhung`). Dr. Chen's email is now `mschen@`, matching the photo filename.
   - **Elis Lin's title** follows the policy ("Elementary School Vice Principal"). The Phase 1 copy and `faculty.html` say "Emotional Wellbeing Specialist".
   - **The principal** appears as "Dr. Chen" because the copy gives no first name.
   - **Nurse email**: the page uses `cwu@` from the Phase 1 copy, but `administration.html` uses `nurse@`.
   - **Dropped claims the policy doesn't support**: police checks "renewed every two years", plus the child-protection training and code-of-conduct wording. The receipt is now named the "Parent-Child Safeguarding Policy Receipt", not the "Anti-Bullying Policy Receipt".
   - **Assumed values**: "Last reviewed October 2026", "Next review July 2027", and the office phone plus `jmanzano@` as the contacts for broken QR codes.
   - **The QR codes** were copied from the supplied images and haven't been scan-tested. Test them on iOS and Android, and check the 113 hotline wording, before publishing.
   - **Not included** from the copy: the welcome video and the explainer video.

## Design decisions

10. **Two title styles.** Accreditation and Strategic Plan use a centered title and italic subtitle. The other pages use eyebrow + two-line left-aligned heading. Both are now documented. Converting acc/stp to the main style would make every page consistent; say if you want it.
11. **Strategic plan button** (`.stp__button`) has a 2px blue border, which breaks the "1px hairlines only" rule. It was kept because a hairline makes a weak call to action. Its grey hover fill is gone; it now changes colour on hover like the safeguarding button.
12. **MLL logo frames** (`.mll__diagram`, `.mll__credit-logo`, `.mll__research-logo`) are white boxes with a rounded corner. They're borderline under "no rounded boxes", but they stop the logos from floating on the page. They were kept.
13. **Staff pages (administration, faculty)** still use the copied live-site CSS, with hex greys and repeated IDs (`#articleInfo16`, `#AB001`…). These are left alone so they match the rest of the CMS. Rebuilding them on the modern design is a separate project.
14. **Unused images get deployed.** No page uses `images/faculty/` (11 MB of CMS staging photos; `eteng.jpg` and `eteng.jpeg` are identical) or `images/other/` (212 files, 60 MB, CMS image downloads). Both are uploaded on every deploy. If nothing outside this repo links to them on the portal, move them to `_originals/` so they stop being deployed.
15. **Heading levels skip.** Accreditation and Strategic Plan use `h4` labels under `h2` titles, and their italic subtitles are `h3`s. It looks right, but screen readers announce an odd outline. Fixing it means changing tags only; the classes already set the look.

## Fixed in this pass

- **Phone headings:** the big uppercase headings on every modern page broke mid-word at phone widths ("MULTILINGU-AL", "ACCREDITATI-ON"). They now shrink to `clamp(26px, 9vw, 46px)` at 640px and below. Safeguarding already had a fix, but it still broke on the narrowest phones.
- **Faculty tabs** are now real links (`href="#boxN"`), so keyboard users can reach them, and the selected tab stays highlighted.
- **Strategic plan:**
  - Roadmap lists had a 20px indent and marker colour, but the reset hides list bullets, so the lists were just indented. Removed both.
  - Open roadmap panels now highlight their title, like the strategic areas and the safeguarding accordions.
  - Objective code, title and description now set their font, as every other text class does.
  - CSS sections were in the wrong order (4 before 3).
- **MUN:** officer cards are now `<article>`s without the extra wrapper. The WJMUN wide photo now has a top-left leaf corner, so it alternates with the photo pair below it.
- **MLL:** tier titles were 24px; they're now the 28px card-title size. The MLRC logo moved to `images/mll/`.
- **Accreditation:** removed dead `embed`/`object` selectors, used `&#39;` instead of `&rsquo;`, and sorted the iframe attributes.
- **CSS:** added a note that most `--*-rgb` values are wrong.
- **Makefile:** the target was `start`, but the comment and `.PHONY` said `serve`. Both names work now.
- **Docs:** tightened CLAUDE.md, documented `_originals/`, `images/other/` and `make serve` in README.md, and re-measured every height in `cms_stubs.html`.
