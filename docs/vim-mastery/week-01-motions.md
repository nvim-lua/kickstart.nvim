# 🎯 Week 1: Motion Basics

Master efficient navigation - the foundation of Vim proficiency.

---

## 🎓 Learning Objectives

By the end of this week, you will:
- Navigate without arrow keys
- Move by words, not characters
- Jump to specific characters on a line
- Understand the power of count + motion
- Be faster than mouse + arrow keys

---

## 📚 Core Commands

### Basic Directional Movement
```vim
h  " Left  ←
j  " Down  ↓
k  " Up    ↑
l  " Right →
```

**Practice Goal**: Use only hjkl for one full day. Unmap arrow keys if needed!

### Word Movement (Most Important!)
```vim
w   " Next word (start)
e   " Next word (end)
b   " Previous word (start)
ge  " Previous word (end)

W   " Next WORD (whitespace separated)
E   " Next WORD (end)
B   " Previous WORD
```

**Difference**:
- `word`: Stops at punctuation (my-function → 3 words)
- `WORD`: Whitespace only (my-function → 1 WORD)

### Line Movement
```vim
0   " Start of line
^   " First non-whitespace character
$   " End of line
g_  " Last non-whitespace character
```

### Character Search (Super Powerful!)
```vim
f{char}   " Find next {char} on line →
F{char}   " Find previous {char} on line ←
t{char}   " Till next {char} (stop before)
T{char}   " Till previous {char}

;         " Repeat last f/F/t/T forward
,         " Repeat last f/F/t/T backward
```

**Pro Tip**: `f` and `t` are game-changers for editing!

---

## 💪 Practice Exercises

### Exercise 1: Word Navigation (5 minutes)
Open any code file:
```vim
:e ~/.config/nvim/init.lua
```

Practice:
1. Use `w` to move forward 10 words
2. Use `b` to come back
3. Use `e` to jump to word ends
4. Compare speed: `wwwww` vs `5w` (count!)

### Exercise 2: Line Precision (5 minutes)
In the same file:
```vim
" Jump to line start
0

" Jump to first character
^

" Jump to line end
$

" Try this combo: Move to end, then back to start
$^
```

### Exercise 3: Character Hunting (10 minutes)
Find a line with multiple parentheses or quotes:
```lua
local function test(arg1, arg2, arg3)
```

Practice:
```vim
f(    " Jump to first (
;     " Jump to next (
;     " Jump to next (
,     " Go back one (
```

Try these scenarios:
- Jump to the closing quote: `f"`
- Delete till comma: `dt,`
- Change till closing paren: `ct)`

### Exercise 4: Combine Motions (10 minutes)
Real-world scenarios:

**Scenario 1**: Change the word "function" to "method"
```vim
" Position cursor on 'f' in function
cw      " Change word
method<Esc>
```

**Scenario 2**: Delete from cursor to end of line
```vim
d$      " or D
```

**Scenario 3**: Change from here to next underscore
```vim
ct_
```

---

## 🎯 Daily Challenges

### Monday: Basic hjkl
- Disable arrow keys: Add to `init.lua`:
  ```lua
  vim.keymap.set('n', '<Up>', '<Nop>')
  vim.keymap.set('n', '<Down>', '<Nop>')
  vim.keymap.set('n', '<Left>', '<Nop>')
  vim.keymap.set('n', '<Right>', '<Nop>')
  ```
- Navigate only with hjkl for the entire day

### Tuesday: Word Motions
- Practice `w`, `b`, `e` every time you move
- Count your keystrokes: `www` = 3, `3w` = 2
- Use counts!

### Wednesday: Line Jumps
- Every time you need line start/end, use `^` or `$`
- Stop using `0` (except when you really need column 0)

### Thursday: Character Search
- Find 10 opportunities to use `f` or `t`
- Practice `;` and `,` for repeating
- Try `dt,` and `ct)` patterns

### Friday: Combinations
- Combine everything: `d3w`, `c$`, `vf)`, etc.
- Edit entire lines without arrow keys
- Feel the power!

---

## 🔥 Real-World Patterns

### Pattern 1: Change Till Character
```vim
" Change from cursor to next comma
ct,
```
**Use when**: Editing function arguments

### Pattern 2: Delete Word Forward
```vim
" Delete from cursor to end of word
dw

" Delete 3 words
d3w
```
**Use when**: Removing variable names

### Pattern 3: Jump and Edit
```vim
" Find opening paren, then change till closing
f(ct)
```
**Use when**: Changing function parameters

### Pattern 4: End of Line Operations
```vim
" Append at end of line
A

" Delete to end of line
D

" Change to end of line
C
```
**Use when**: Adding semicolons, removing trailing code

---

## 📊 Progress Checklist

Track your mastery:

```
Day 1:
[ ] Used hjkl instead of arrows at least 50% of time
[ ] Felt uncomfortable (this is good!)

Day 2:
[ ] Used w/b/e consciously 20+ times
[ ] Started thinking in "words" not "characters"

Day 3:
[ ] Used ^ and $ instead of Home/End
[ ] Comfortable with 0/^/$ distinction

Day 4:
[ ] Used f/t successfully 10+ times
[ ] Discovered one "aha!" moment with dt or ct

Day 5:
[ ] Combined motions (d3w, c$, etc.)
[ ] Hjkl feels natural
[ ] Ready for Week 2!
```

---

## 🎮 Speed Drills

### Drill 1: The Word Race (2 minutes)
```vim
" Open a file
" Start at top: gg
" Goal: Get to word "function" on line 50

" Slow way: jjjjjjjjwwwwwwww
" Fast way: 50G/function<CR>
" Week 1 way: 50G (jump to line) then use w/e
```

### Drill 2: Line Ninja (2 minutes)
```vim
" Create test line:
" the quick brown fox jumps over the lazy dog

" Tasks (as fast as possible):
0       " Line start
$       " Line end
^       " First char
fb      " Find 'b'
;       " Next 'b'
e       " End of word
```

### Drill 3: Edit Marathon (5 minutes)
```lua
-- Start with:
local result = calculate(arg1, arg2, arg3, arg4)

-- Tasks:
-- 1. Change "calculate" to "compute"
--    Solution: /calc<CR>cw compute<Esc>
--
-- 2. Delete ", arg4"
--    Solution: f4 (on '4') then dF, (delete back to comma)
--
-- 3. Change "result" to "output"
--    Solution: 0 (start of line) cw output<Esc>
```

---

## 💡 Pro Tips

### Tip 1: Think in Motions
Don't think: "I need to move 5 characters right"
Think: "I need to move to the next word"

### Tip 2: Use Counts
`5w` is faster than `wwwww` and requires less thought.

### Tip 3: f/t Are Superpowers
Once you master `f` and `t`, you'll never want to use arrow keys for horizontal navigation.

### Tip 4: Learn the Difference
- `w` stops at punctuation: `my-word` = 3 stops
- `W` only stops at whitespace: `my-word` = 1 stop

### Tip 5: Combine with Operators
Motions are 10x powerful with operators (d, c, y):
- `dw` = delete word
- `ct.` = change till period
- `y$` = yank to end of line

---

## 🎯 Week 1 Goal

**By end of week, you should prefer hjkl + word motions over arrow keys.**

If you catch yourself reaching for arrows or mouse, that's your cue to practice more!

---

## 🔗 Quick Reference Card

Print this or keep it visible:

```
┌─────────────────────────────────────┐
│        Week 1: Motion Basics        │
├─────────────────────────────────────┤
│ hjkl      - Directions              │
│ w/b/e     - Word motions            │
│ ^/$       - Line start/end          │
│ f/F       - Find character          │
│ t/T       - Till character          │
│ ;/,       - Repeat find             │
│                                     │
│ Combos:                             │
│ dw        - Delete word             │
│ dt,       - Delete till comma       │
│ c$        - Change to end           │
│ 5w        - Move 5 words            │
└─────────────────────────────────────┘
```

---

## ❓ Common Questions

**Q: Why not use arrow keys?**
A: They're far from home row. Hjkl is faster once trained.

**Q: When should I use w vs W?**
A: Use `w` for code (stops at punctuation). Use `W` for prose (whitespace only).

**Q: I'm slower with hjkl!**
A: Normal! Stick with it for 3 days. Speed comes after correctness.

**Q: Do I really need to learn f/t?**
A: YES! They're the secret weapon. Worth the practice.

---

## 🎊 Graduation Criteria

You're ready for Week 2 when:
- ✅ hjkl feels natural (no conscious thought)
- ✅ You use w/b/e more than arrow keys
- ✅ You've used f/t successfully in real work
- ✅ You can navigate without looking at keyboard
- ✅ You feel frustrated when using arrow keys

---

<div align="center">

**Congratulations on completing Week 1!**

Practice these daily, and they'll become second nature.

[← Back to Vim Mastery](README.md) | [Week 2: Text Objects →](week-02-text-objects.md)

</div>
