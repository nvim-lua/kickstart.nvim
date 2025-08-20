---
name: Rebase Reminder
about: Automated reminder to rebase active worktrees
title: '⚠️ Rebase Reminder: [PR NUMBER]'
labels: rebase-reminder, automated
assignees: ''
---

## Action Required
PR #[NUMBER] has been merged to main. Active worktrees should be rebased.

## Steps to Rebase

```bash
# Update main
cd ~/dev/projects/[PROJECT]
git fetch origin main
git pull origin main

# For each active worktree
cd ~/dev/worktrees/[PROJECT]/[WORKTREE]
git rebase origin/main
git push --force-with-lease
```

## Checklist
- [ ] Main branch updated
- [ ] Active worktrees identified
- [ ] Each worktree rebased
- [ ] Changes pushed with --force-with-lease

---
*This is an automated reminder. Close this issue once all worktrees are rebased.*
