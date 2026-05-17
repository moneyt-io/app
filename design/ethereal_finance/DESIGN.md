---
name: Ethereal Finance
colors:
  surface: '#faf8ff'
  surface-dim: '#d2d9f4'
  surface-bright: '#faf8ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f2f3ff'
  surface-container: '#eaedff'
  surface-container-high: '#e2e7ff'
  surface-container-highest: '#dae2fd'
  on-surface: '#131b2e'
  on-surface-variant: '#434655'
  inverse-surface: '#283044'
  inverse-on-surface: '#eef0ff'
  outline: '#737686'
  outline-variant: '#c3c6d7'
  surface-tint: '#0053db'
  primary: '#004ac6'
  on-primary: '#ffffff'
  primary-container: '#2563eb'
  on-primary-container: '#eeefff'
  inverse-primary: '#b4c5ff'
  secondary: '#006c49'
  on-secondary: '#ffffff'
  secondary-container: '#6cf8bb'
  on-secondary-container: '#00714d'
  tertiary: '#784b00'
  on-tertiary: '#ffffff'
  tertiary-container: '#996100'
  on-tertiary-container: '#ffeedd'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#dbe1ff'
  primary-fixed-dim: '#b4c5ff'
  on-primary-fixed: '#00174b'
  on-primary-fixed-variant: '#003ea8'
  secondary-fixed: '#6ffbbe'
  secondary-fixed-dim: '#4edea3'
  on-secondary-fixed: '#002113'
  on-secondary-fixed-variant: '#005236'
  tertiary-fixed: '#ffddb8'
  tertiary-fixed-dim: '#ffb95f'
  on-tertiary-fixed: '#2a1700'
  on-tertiary-fixed-variant: '#653e00'
  background: '#faf8ff'
  on-background: '#131b2e'
  surface-variant: '#dae2fd'
typography:
  display-lg:
    fontFamily: Manrope
    fontSize: 40px
    fontWeight: '800'
    lineHeight: 48px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Manrope
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
    letterSpacing: -0.01em
  headline-lg-mobile:
    fontFamily: Manrope
    fontSize: 24px
    fontWeight: '700'
    lineHeight: 32px
  headline-md:
    fontFamily: Manrope
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
  body-lg:
    fontFamily: Manrope
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
  body-md:
    fontFamily: Manrope
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  label-md:
    fontFamily: Manrope
    fontSize: 14px
    fontWeight: '600'
    lineHeight: 20px
    letterSpacing: 0.01em
  label-sm:
    fontFamily: Manrope
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  unit: 4px
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 40px
  gutter: 16px
  margin-mobile: 20px
  margin-desktop: 64px
---

## Brand & Style

The design system is rooted in **Minimalism** with a **Corporate Modern** edge, specifically tailored for a high-end personal finance experience. It aims to evoke feelings of clarity, calm, and absolute control over one’s wealth. The aesthetic relies on expansive whitespace, a "white-on-white" layering technique, and precise typography to convey sophistication.

The target audience is the modern professional who values efficiency and aesthetic refinement. By using subtle depth instead of loud decorative elements, the system ensures that complex financial data remains the hero, presented in a way that feels premium and approachable.

## Colors

The palette is anchored by a "Pure Light" philosophy. Surfaces use a mix of pure white and extremely desaturated grays to create soft contrast without visual noise.

- **Primary (Royal Blue):** Used for primary actions, active states, and brand highlights. It denotes trust and stability.
- **Success (Emerald Green):** Used for "Total Savings," positive growth trends, and income indicators.
- **Accent (Soft Gold):** Reserved for "Total Expenses," luxury categories, or specific warnings that require attention without causing panic.
- **Neutrals:** The text hierarchy uses a deep Navy-Black for legibility, while borders and secondary icons use cool-toned grays to maintain the "airiness" of the UI.

## Typography

This design system utilizes **Manrope** for its geometric yet warm character. The hierarchy is strictly enforced to ensure financial figures are the most prominent elements.

- **Numbers:** Use `Display-lg` or `Headline-lg` for account balances. Bold weights are preferred for currency to provide immediate "glanceability."
- **Readability:** Body text uses a generous line height (1.5x) to prevent dense financial logs from feeling overwhelming.
- **Labels:** Uppercase or semi-bold small labels are used for category headers to differentiate them from actionable data.

## Layout & Spacing

The layout follows a **Fluid Grid** model with a focus on "Generous Breathability." 

- **Desktop:** 12-column grid with 24px gutters. Content is often centered in a max-width container (1280px) to maintain focus.
- **Mobile:** 4-column grid with 20px side margins.
- **Rhythm:** All spacing is based on a 4px baseline. Components typically use `lg` (24px) padding to ensure a luxurious, uncrowded feel. Vertical stacking of cards should utilize `md` (16px) or `lg` (24px) gaps to maintain distinct elevation layers.

## Elevation & Depth

This design system uses **Ambient Shadows** and **Tonal Layering** to create a sense of soft physical depth.

- **Level 0 (Background):** `#F8FAFC` - The base canvas.
- **Level 1 (Cards/Containers):** Pure `#FFFFFF` with a very soft, diffused shadow: `0px 4px 20px rgba(15, 23, 42, 0.05)`. This makes the white elements "float" over the slightly gray background.
- **Level 2 (Modals/Overlays):** Increased shadow spread: `0px 12px 40px rgba(15, 23, 42, 0.1)`.
- **Interaction:** On hover, cards may subtly lift by increasing the shadow spread and shifting -2px on the Y-axis.

## Shapes

The shape language is defined by **Rounded (0.5rem base)** corners. 

- **Small Components:** Checkboxes and small tags use `rounded` (0.5rem).
- **Standard Cards:** Use `rounded-lg` (1rem) to create a friendly, modern container.
- **Main Action Buttons:** Use `rounded-xl` (1.5rem) or full pill-shape to distinguish them from informational containers.
- **Icons:** Should be housed in rounded-square backgrounds with consistent padding.

## Components

- **Buttons:** Primary buttons use the Brand Blue with white text. Secondary buttons use a light gray ghost style or a subtle blue-tinted stroke.
- **Cards:** White backgrounds only. Use `label-sm` for titles and `headline-md` for the primary data point within the card.
- **Input Fields:** Soft gray backgrounds (`#F1F5F9`) with no borders in their default state. They transition to a white background with a 2px Primary Blue border on focus.
- **Category Indicators (Chips):** Use highly desaturated versions of the category color as a background (e.g., 10% opacity Emerald) with full-saturation text for the label.
- **Progress Bars / Charts:** Use rounded caps and high-contrast vibrant colors against a light gray track.
- **Lists:** Transaction lists should remove borders between items, using whitespace and subtle vertical alignment to separate entries.