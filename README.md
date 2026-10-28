# memory-kit · a home for your AI

> **Your AI is a stranger every time it wakes up. Instead of reintroducing yourself, give it a room.**

Not a program — a folder skeleton plus a few writing rules.
Drop it into an agent's workspace and the agent has somewhere to write down what it learns,
so that next session it reads it back instead of starting from zero.

Sister project: [handoff-kit](https://github.com/hanakujira/handoff-kit) compresses **one day** of messy log into a one-page handoff.
memory-kit is the **long term**: where it lives, where things go, what to keep and what to move out of the way.

## Three rules

1. **Only what is written down is remembered.**
   When the context clears, anything not in a file is gone. "I'll do this next" and "she said she hates that"
   have to be in a file, or they never happened. The workspace is not a notebook — it *is* the memory.

2. **One subject per file, named so the name alone tells you whether to open it.**
   `partner/food-likes-and-dislikes.md` — you know. `notes2.md` — you have to open it to find out, so you never will.
   Search before creating; if a file on that subject exists, change that one.

3. **Whatever is read every turn must stay short; move the stories elsewhere.**
   `PARTNER.md` is read on every request, so it is a **distilled portrait**, not a biography.
   Detail, timelines and context live in `partner/` and are read when needed.

## Layout

```
CONSTITUTION.md      who I am. In the prefix every turn; whatever it says, that is what I am
PARTNER.md           who they are. Short, distilled, read every request
notes/               one subject per file: projects, rules, todos, glossary
  glossary.md        names: who is who. Read first, so nothing gets mixed up
log/YYYY-MM.md       running log, one file per month, append only
partner/             detail about the person: stories, preferences, timeline
handoffs/            one note per session, written before the context clears
archive/             finished and stale things, moved whole. Never deleted, just out of the way
```

| File | Read when | Holds |
|---|---|---|
| `CONSTITUTION.md` | every session, automatically | identity, character, how it speaks, hard lines. Written in second person: "you are…" |
| `PARTNER.md` | every request, automatically | the person: glossary, name, likes, communication style, standing permissions, landmines. **Keep it short** |
| `notes/glossary.md` | on start | people, programs, projects — which nickname means who |
| `notes/*.md` | when doing the work | one subject each: how a project runs, a set of rules, a pitfall |
| `log/YYYY-MM.md` | when looking back | append only: `- 21:40 ✅ fixed X (commit abc123)` |
| `handoffs/` | when taking over | what we are waiting on, current state, next step, pitfalls |
| `partner/` | when editing `PARTNER.md` | why they like it, what day they said it, the whole conversation |

## Four writing rules

1. **Search before creating a file.** One grep is cheaper than a second copy of the same subject.
2. **When a fact changes, rewrite it in place.** Never append "correction: …" below it — the stale line gets read next time.
3. **Put the date in the filename when it is time-bound.** Running logs are one per month; one-offs are `2026-10-28-something.md`.
4. **Move, do not delete.** Move a whole finished file or folder into `archive/`; search still finds it there.

## Handing off

Before the context clears, write one page in `handoffs/<time>.md` with at least four sections:

```markdown
## Waiting on      <- blocked by whom, waiting for which answer
## Current state   <- numbers, commits, paths, setting values
## Next step       <- the first thing the next session should do
## Pitfalls        <- what bit us today and will bite again tomorrow
```

Only then let it be cleared. An agent that skips this step is born again every time.

## One room, how many agents?

**One room, one agent.**
`CONSTITUTION.md` is *who I am*, `PARTNER.md` is *who I look after*, `notes/` is the record of the work.
When the model changes, what moves is the brain, not the room — the newcomer reads these files and carries on, without meeting the person all over again.

**Sharing a room is fine, if you write the division of labour first.**
Two or more agents in one room need `notes/division-of-labor.md`: who owns which files, who must not touch which, who talks to the person.
Add handoffs too: whoever finishes a stretch writes a page in `handoffs/`, so the next one does not have to start from strangers.

The difference between multiple agents is not "who does what" — that is just a flowchart. It is that **each one remembers the other.**

## Getting started

```powershell
# copy the skeleton into your agent's workspace (never overwrites existing files)
powershell -NoProfile -ExecutionPolicy Bypass -File .\install.ps1 -Dest "D:\my-agent\workspace"
```

1. Fill in `CONSTITUTION.md` in the second person — as if telling it who it is.
2. Fill the glossary in `PARTNER.md`; the long version goes in `notes/glossary.md`.
3. On the first conversation, say: **"Read CONSTITUTION.md and PARTNER.md first, then answer."**
4. From then on, when it learns something, tell it to *write it into a file* — not just nod in the chat.

## Where this came from

It was not designed; it was lived in. This is the workspace of a desktop-pet agent that has been running for months —
after hitting the real pitfalls: two files contradicting each other, `PARTNER.md` growing to 800 lines that were
read on every single request, and a context clear with no handoff note, which meant re-learning everything the next day.
