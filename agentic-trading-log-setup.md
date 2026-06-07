# Trading Log — Installer

> **For the human:** Just tell your Claude: *"Read INSTALL.md and set up my trading log."*
> Claude will read this file, ask you a few questions, and build everything in this folder.
> You don't need to read or understand the rest of this file — it's instructions for Claude.

---
<!-- ============================================================
     CLAUDE: Everything below this line is your instructions.
     Read them fully before doing anything. Follow every step.
     ============================================================ -->

## Claude — What You Are Building

You are setting up a **3-file agentic trading log system** for this user. Once installed, the system lets you (and future Claude sessions) track trades, enforce strategy rules, propose setups, and maintain a persistent record that survives context resets.

The three files you will create are:
- `trading-strategy-log.md` — active proposal, trade log, running stats
- `trading-strategy-rules.md` — scoring system, position sizing, proposal/check-in formats
- `trading-strategy-archive.md` — scan notes, eliminated candidates, post-trade reviews

**Do not create any files until Step 4.** Collect all answers first.

---

## Step 1 — Introduce the System

Tell the user (briefly, no more than 3–4 sentences):
- You're going to set up a personalized trading log in this folder
- It will let you track trades, score setups, and give check-ins on open positions
- You need to ask about 10–12 short questions first
- It takes about 2–3 minutes

---

## Step 2 — Ask the Onboarding Questions

Ask all questions below. You may group them naturally in conversation — don't make it feel like a form. Collect every answer before moving to Step 3.

### Group A — Broker & Account
1. What trading platform or broker do you use? *(e.g. Robinhood, Schwab, TD Ameritrade, Webull, IBKR, other)*
2. What is your starting capital for this account? *(approximate is fine)*
3. What do you want to call this account? *(e.g. "Main Brokerage", "Robinhood Swing", "Roth IRA" — this is just a label)*

### Group B — Goals
4. What is your primary goal with this account? *(e.g. income generation, capital growth, learning to trade, retirement savings)*
5. What growth rate are you targeting? *(e.g. 1% per week, 5% per month — be realistic, not aspirational)*
6. What is the maximum dollar amount you are comfortable losing on a single trade?

### Group C — Trading Style
7. What is your preferred trading style?
   - Swing trades — hold 1 day to 1 week
   - Position trades — hold 1 to 4 weeks
   - Day trading — in and out same day
   - Not sure yet / mixed
8. Do you have a sector or asset preference, or do you want the best opportunity regardless of sector?
9. How many positions do you want open at once? *(1 is recommended for beginners; up to 3 for experienced traders)*
10. For trade execution: do you want to **approve every trade** before it goes through, or do you prefer **fully autonomous** execution?

### Group D — Risk Profile
11. How would you describe your risk tolerance?
    - Conservative — capital preservation first, modest gains
    - Moderate — balanced, some volatility is acceptable
    - Aggressive — willing to accept large swings for larger potential gains
12. Do you want a hard stop-loss enforced on every trade? *(Strongly recommended: Yes)*
13. Do you want a minimum risk/reward ratio enforced? *(e.g. only take trades with at least 1:2 R/R — meaning risk $1 to make $2)*

---

## Step 3 — Confirm Before Creating

Summarize the user's answers in a short table and ask:

> "Does this look right? I'll build your three trading log files based on this."

**Wait for confirmation.** If they want to adjust anything, update your notes and confirm again.

---

## Step 4 — Create the Three Files

Create the files in the **same folder as this INSTALL.md file**. Replace every `[PLACEHOLDER]` with the user's actual answers. Use today's date for `[TODAY_DATE]`.

---

### File 1: `trading-strategy-log.md`

~~~~markdown
# [BROKER] Agentic Trading Log

**Account:** [ACCOUNT_NICKNAME]
**Capital:** $[STARTING_CAPITAL] (as of [TODAY_DATE])
**Goal:** [GROWTH_RATE_TARGET] — e.g. 1% per week

---

## Active Proposal

*No active proposal. Ask Claude to run a scan to generate one.*

---

## Trade Log

| # | Date | Ticker | Entry $ | Stop $ | Target $ | Est. Hold | Exit $ | P&L % | Score | Actual Days | Outcome |
|---|------|--------|---------|--------|----------|-----------|--------|-------|-------|-------------|---------|
| — | — | — | — | — | — | — | — | — | — | — | *No trades yet* |

---

## Running Stats

| Metric | Value |
|--------|-------|
| Total trades | 0 |
| Wins / Losses | 0 / 0 |
| Win rate | — |
| Avg win % | — |
| Avg loss % | — |
| Total P&L | $0.00 (0%) |
| Account value | $[STARTING_CAPITAL] |
| [Weekly/Monthly] target | $[TARGET_DOLLAR] ([GROWTH_RATE_TARGET]) |

---

## Recent Amendments

| Date | Change |
|------|--------|
| [TODAY_DATE] | Trading log created via INSTALL.md |
~~~~

---

### File 2: `trading-strategy-rules.md`

~~~~markdown
# [BROKER] Agentic Trading — Strategy Rules

*Reference file. Load this when running a scan or reviewing a position.*

---

## Strategy Rules

| Rule | Setting |
|------|---------|
| Stock universe | [e.g. "Any price — fractional shares enabled" or "Whole shares only, min price $5"] |
| Sector preference | [SECTOR_PREFERENCE or "None — best opportunity wins"] |
| Signal method | **Hybrid:** technical + news/catalysts + unusual volume |
| Risk/Reward minimum | **[e.g. 1:2]** per trade |
| Max single-trade loss | **[e.g. $50 or 2% of portfolio]** |
| Stop-loss | Defined at entry, every trade |
| Profit target | Defined at entry, every trade |
| Hold duration | [e.g. "1 day to 1 week (swing trades)"] |
| Max open positions | [MAX_POSITIONS] |
| Position sizing | Score-based (see below) |
| Scan frequency | On-demand — user asks for a scan |
| Approval flow | [e.g. "Claude proposes → user approves → Claude executes" or "Fully autonomous"] |
| No-setup rule | **Stay in cash.** No trade is a valid trade. |

---

## Position Sizing

Goal: capture [GROWTH_RATE_TARGET] of portfolio per [week/month] via [one/up to N] focused position[s].

Adjust deployed capital based on signal confidence:

| Signal Score | Capital Deployed |
|-------------|-----------------|
| 6/9 (minimum threshold) | 50% |
| 7/9 | 65–70% |
| 8/9 | 80–85% |
| 9/9 | 90–100% |

[If user is CONSERVATIVE: cap maximum deployed capital at 70% regardless of score.]
[If user is AGGRESSIVE: 9/9 may go up to 100%; keep the table as-is.]
[If user is MODERATE: use the table as-is.]

Scores with caveats (unverified data, live risk events) always take the lower end of the range.

---

## Stock Selection Scoring Criteria

**Minimum score to propose a trade: 6/9.**
If no stock clears 6/9, Claude recommends staying in cash.

### Technical (0–3 pts)
> **Online technical analysis must be sourced and cited before scoring this category.
> No points are awarded without verified external data.**

- **1 pt** — Price is above a key moving average (20 or 50 EMA)
- **1 pt** — Momentum is confirmed (RSI 40–70 trending; MACD cross or expansion)
- **1 pt** — A clear support/resistance level defines a clean entry zone

### News / Catalyst (0–3 pts)
- **1 pt** — A recent news event (earnings beat, announcement, partnership, macro tailwind)
- **1 pt** — The catalyst is sector-relevant and not already fully priced in
- **1 pt** — No major headwinds or conflicting negative news

### Volume / Activity (0–3 pts)
- **1 pt** — Volume spike vs. 20-day average (>1.5×)
- **1 pt** — Unusual options or institutional activity detected
- **1 pt** — Price action confirms volume (no divergence — avoid distribution patterns)

---

## Trade Proposal Format

When proposing a trade, always use this exact format:

```
TRADE PROPOSAL — [DATE]

Ticker:         $XXXX
Signal Score:   X/9 (Tech: X | Catalyst: X | Volume: X)
Reasoning:      [Why this stock, why now — 2–3 sentences]
Entry Zone:     $XX.XX – $XX.XX
Stop-Loss:      $XX.XX  (-X%)
Profit Target:  $XX.XX  (+X%)
Risk/Reward:    1:X
Est. Hold:      X days
Position Size:  X% of available capital

APPROVE / REJECT?
```

---

## Check-In Format

When checking on an open position, always use this exact format:

```
$TICKER CHECK-IN — [DATE TIME]

Price:          $XX.XX  (±X% from entry $XX.XX)
Stop:           $XX.XX  ✓ safe / ⚠ approaching / ✗ breached
Target:         $XX.XX  (X% of the way there)
Signal Score:   X/9 — [unchanged / updated: reason]
Momentum:       [brief read on price action or news since last check]
Verdict:        HOLD / TAKE PROFIT / CUT LOSSES
```

If verdict is anything other than HOLD, ask the user for confirmation before acting.
If signal score drops mid-trade, treat it as an early warning even if price hasn't moved yet.
~~~~

---

### File 3: `trading-strategy-archive.md`

~~~~markdown
# [BROKER] Agentic Trading — Archive

*Full scan notes, eliminated candidates, post-trade reviews, and amendment history.*

---

## Full Amendment Log

| Date | Change | Reason |
|------|--------|--------|
| [TODAY_DATE] | Trading log system created | Initial setup via INSTALL.md |
| [TODAY_DATE] | Strategy configured: [one-line summary of user's key choices] | User onboarding |
~~~~

---

## Step 5 — Save a Memory (if your memory system supports it)

After creating the files, save a memory with:
- Broker and account nickname
- Starting capital and growth goal
- Risk tolerance
- Trading style (swing / day / position)
- Max positions
- Approval flow preference
- Path to the trading log folder

This ensures future Claude sessions start with full context without re-reading the files.

---

## Step 6 — Confirm and Offer Next Steps

After creating all three files, tell the user:

> **Your trading log is live.** Here's how to use it:
>
> - **Run a scan** — Ask: *"Scan for a trade"* or *"What should I buy this week?"* Claude will score candidates and propose the best setup.
> - **Check a position** — Ask: *"Check my position"* — Claude will pull a live quote and give you a HOLD / TAKE PROFIT / CUT LOSSES verdict.
> - **Log a trade** — After you approve and execute, tell Claude the entry price and it will update the log.
> - **Adjust your rules** — Your rules file is the single source of truth. Tell Claude any time you want to change something.
>
> Want to run your first scan now?

---

*Installer v1.0 — 2026-06-07*
