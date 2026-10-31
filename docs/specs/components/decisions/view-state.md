# View state: decisions

- Q-1 Should the default loading label carry an ellipsis, as Apple platforms' in-progress labels usually do? Answer: yes, "Wczytywanie…" and "Loading…" with the ellipsis character; the canvas page follows (review round 1).
- Q-2 The owner's `.task` on a view that switches cases, loading set again during loading, and an area offered an unbounded axis had no behavior. Answer: one identity across cases, so `.task` and `.onAppear` start once and are never restarted by a change of case; loading set again keeps the running delay or the shown indicator, and the area is empty for accessibility before the delay; along an unbounded axis the area takes its ideal size (review round 1).
