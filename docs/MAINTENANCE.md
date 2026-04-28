# GitHub Pages Maintenance Guide

This guide explains how to maintain and update the GitHub Pages site for the s390x ABI documentation.

## Overview

The GitHub Pages site is hosted from the `docs/` folder on the main branch. It consists of:
- `index.html` - The landing page
- `styles.css` - Styling and responsive design
- `lzsabi_s390x.pdf` - The current PDF version of the specification

## Updating the PDF

When you make changes to the LaTeX source and want to publish a new version:

### 1. Build the PDF

```bash
# From the repository root
make
```

This generates `lzsabi_s390x.pdf` in the root directory.

### 2. Copy to docs folder

```bash
cp lzsabi_s390x.pdf docs/
```

### 3. Update version information (optional)

Edit `docs/index.html` and update the "Last Updated" date:

```html
<p class="version-info">Current Version • Last Updated: <time datetime="YYYY-MM-DD">Month Year</time></p>
```

Replace `YYYY-MM-DD` with the ISO date (e.g., `2026-04-28`) and `Month Year` with the human-readable date (e.g., `April 2026`).

### 4. Commit and push

```bash
git add docs/lzsabi_s390x.pdf docs/index.html
git commit -m "Update PDF to version X.Y"
git push origin main
```

### 5. Verify deployment

GitHub Pages typically updates within 1-2 minutes. Visit:
https://ibm.github.io/s390x-abi/

to verify the changes are live.

## Updating the HTML Page

### Modifying Content

Edit `docs/index.html` to change:
- Page title and description
- Version information
- Links and resources
- About section text

### Modifying Styles

Edit `docs/styles.css` to change:
- Colors (modify CSS variables in `:root` and `@media (prefers-color-scheme: dark)`)
- Layout and spacing
- Typography
- Responsive breakpoints

**Dark Mode Support:** The site automatically switches between light and dark themes based on the user's system preference. Both themes use CSS variables defined in `styles.css`:
- Light theme: Default `:root` variables
- Dark theme: Variables inside `@media (prefers-color-scheme: dark)`

### Testing Changes Locally

Before pushing changes, test them locally:

```bash
# Using Python (Python 3)
cd docs
python3 -m http.server 8000

# Or using Node.js
npx http-server docs -p 8000
```

Then open http://localhost:8000 in your browser.

## GitHub Pages Configuration

The site is configured in the repository settings:

1. Go to repository Settings → Pages
2. Source: Deploy from a branch
3. Branch: `main`
4. Folder: `/docs`

**Note:** Only repository administrators can modify these settings.

## File Structure

```
docs/
├── index.html          # Main landing page
├── styles.css          # CSS styling
├── lzsabi_s390x.pdf    # Current PDF (tracked in git)
└── MAINTENANCE.md      # This file
```

## Common Tasks

### Adding a New Section

1. Edit `docs/index.html`
2. Add your content within a `<section>` tag in the `<main>` element
3. Style it using existing CSS classes or add new ones to `styles.css`
4. Test locally
5. Commit and push

### Changing Colors

Edit the CSS variables in `docs/styles.css`:

```css
:root {
    --primary-color: #2c3e50;      /* Main dark color */
    --secondary-color: #34495e;    /* Secondary dark color */
    --accent-color: #3498db;       /* Links and buttons */
    --text-color: #333;            /* Body text */
    --text-light: #666;            /* Secondary text */
    /* ... */
}
```

### Adding Links

Add new links to the "Resources" section in `index.html`:

```html
<ul class="resource-links">
    <li><a href="URL">📌 Link Text</a></li>
    <!-- Add more links here -->
</ul>
```

## Troubleshooting

### PDF not updating

1. Clear your browser cache (Ctrl+Shift+R or Cmd+Shift+R)
2. Check that the file was committed: `git log docs/lzsabi_s390x.pdf`
3. Wait 2-3 minutes for GitHub Pages to rebuild
4. Check GitHub Actions tab for any deployment errors

### Page not displaying correctly

1. Check browser console for errors (F12)
2. Verify all files are committed: `git status`
3. Test locally to isolate the issue
4. Check that `styles.css` is loading (view page source)

### Changes not appearing

1. Verify you pushed to the correct branch: `git branch`
2. Check GitHub Pages settings (Settings → Pages)
3. Look for build errors in repository Actions tab
4. Try a hard refresh in your browser

## Best Practices

1. **Always test locally** before pushing changes
2. **Keep commits atomic** - one logical change per commit
3. **Write descriptive commit messages** - explain what and why
4. **Update version dates** when publishing new PDFs
5. **Validate HTML** - use https://validator.w3.org/
6. **Check accessibility** - test with keyboard navigation
7. **Test on mobile** - use browser dev tools responsive mode

## Backup and Recovery

The entire site is version-controlled in git. To restore a previous version:

```bash
# View history
git log docs/

# Restore a specific file from a commit
git checkout COMMIT_HASH -- docs/index.html

# Or restore entire docs folder
git checkout COMMIT_HASH -- docs/
```

## Future Enhancements

Potential improvements to consider:

- Add HTML version of the specification (generated from LaTeX)
- Create version history page with links to previous releases
- Add search functionality
- Add analytics (if desired)
- Create automated deployment via GitHub Actions

## Support

For questions or issues:
- Open an issue: https://github.com/ibm/s390x-abi/issues
- Review the main README: https://github.com/ibm/s390x-abi#readme
