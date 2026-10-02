# Live PostIt — Design System

The website's visual source of truth. Every color, type, and layout decision below
has a one-line reason (antislop R-31). If a future change can't be justified here, don't make it.

## 1. Identity

- **Concept:** "The Wall." The page should feel like a physical wall of sticky notes:
  warm paper, hand-written notes, soft depth, playful but disciplined.
- **Personality:** warm, personal, tactile, crafted. Not corporate, not sterile.
- **Subject:** a desktop sticky-note app. The most characteristic thing in its world is
  a hand-written note pinned to a wall, so that is the hero, not a generic headline + CTA.

## 2. Dials (antislop Part 3)

- **ENERGY 2 (Balanced):** says hello with warmth and a little play, stays disciplined.
- **RHYTHM 3 (Varied):** sections visibly differ (asymmetric hero, note mosaic, flow, accordion).
- **MOTION 2 (Balanced):** scroll-reveal, hover lifts on notes, subtle. No parallax overload.

## 3. Palette (warm paper + sticky-note colors)

| Token | Hex | Role / reason |
|---|---|---|
| `--paper` | `#F4EEE1` | warm cream "wall" background; sets the physical-paper tone |
| `--paper-2` | `#ECE3D2` | deeper paper for a couple of sections to add depth (not alternating every section) |
| `--ink` | `#241D12` | warm near-black; primary text, high contrast on paper |
| `--ink-soft` | `#6E6353` | warm grey; secondary text, still 4.5:1+ on paper |
| `--line` | `#E0D4BC` | warm hairline borders |
| `--surface` | `#FFFFFF` | white note / card base |
| `--accent` | `#F2A20C` | marigold, the classic sticky-note yellow; the ONE accent, used on the primary CTA and key moments |
| `--accent-deep` | `#B9790A` | darker marigold for accent text on paper (meets 4.5:1) |
| `--note-sun` | `#FFD64D` | sticky-note yellow (product palette, hero wall + feature notes) |
| `--note-rose` | `#FF9FB6` | sticky-note pink |
| `--note-sky` | `#7EC8F2` | sticky-note blue |
| `--note-mint` | `#8FE0B4` | sticky-note green |

Palette is 2 cores (paper, ink) + 1 accent (marigold). The four note colors are the
product's own representation, used inside notes, not as the page's design system (R-29).

## 4. Typography

- **Display:** "Shantell Sans" (hand-drawn, warm, characterful). Used for the hero headline,
  section headings, and the sticky-note content. Reason: a hand-drawn face is the single most
  on-brand, non-default choice for a sticky-note app; it makes the page feel hand-made.
- **Body:** "Nunito Sans" (rounded, warm, highly legible). Used for body text, buttons, UI.
  Reason: rounded and friendly, matches the tactile clay feel, reads well at body size.
- Scale: hero ~64px, section h2 ~40px, h3 ~20px, body 16-17px, small 14px.

## 5. Signature element

The **interactive sticky-note wall** in the hero: a cluster of CSS-rendered notes with real,
specific content, at slight rotations, with soft warm shadows and hand-written text. On hover a
note lifts. This is the thing the page is remembered by (frontend-design: one memorable element).

## 6. Effects (tactile / claymorphism-lite)

- Soft, warm-tinted layered shadows on notes and cards to give physical depth (R-12, elevation only).
- Slight rotations (2-5deg) on notes, like real pinned notes.
- Varied radius: notes 10px, cards 18px, buttons 12px (R-11, radius as a hierarchy tool, not all pills).
- Hover: notes lift (translateY + shadow grow + rotation eases toward 0); buttons press (scale .98).
- Very subtle paper grain (low-opacity noise) on the background, justified by the paper identity (R-07).
- A small "tape" strip on some notes for physicality.

## 7. Icons

Custom inline SVGs, one consistent style (24px, 2px stroke, rounded caps, currentColor),
chosen for relevance to each feature (R-04). No emoji, no generic sparkle/star/orb set.

## 8. Copy rules

- No em dashes (R-02): use commas, periods, colons, or parentheses.
- No AI buzzwords (R-16): specific, plain language.
- No fake stats or testimonials (R-17, R-18): the app has no public metrics, so none are shown.
- Every nav link and button has a real destination (R-24, R-26).

## 9. Decision log

- **Why paper background instead of white?** It reads as a physical wall, the product's core metaphor.
- **Why a hand-drawn display font?** It is the product's essence (hand-written notes) and avoids the AI-default sans.
- **Why marigold as the single accent?** It is the canonical sticky-note color; one accent keeps a focal point.
- **Why features as notes of varied sizes?** Mirrors the product (a wall of notes) and avoids the uniform-card-grid slop (R-14).
- **Why no testimonial or stats section?** The product has none to show; an empty page is better than a fabricated one (R-17, R-18, R-38).
