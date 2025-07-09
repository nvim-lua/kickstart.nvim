#!/bin/bash
# Test if nvim-claude plugin loads correctly

echo "Testing nvim-claude plugin..."

# Test 1: Check if nvim loads without errors
echo -n "Test 1 - Plugin loads: "
nvim -c "echo 'Testing plugin load'" -c "qa" 2>&1
if [ $? -eq 0 ]; then
    echo "✓ PASSED"
else
    echo "✗ FAILED"
    exit 1
fi

# Test 2: Check if commands are available
echo -n "Test 2 - Commands exist: "
OUTPUT=$(nvim -c "echo exists(':ClaudeChat')" -c "qa!" 2>&1 | tail -1)
if [[ "$OUTPUT" == *"2"* ]]; then
    echo "✓ PASSED"
else
    echo "✗ FAILED - ClaudeChat command not found"
    exit 1
fi

# Test 3: Check tmux availability
echo -n "Test 3 - Tmux available: "
if command -v tmux &> /dev/null; then
    echo "✓ PASSED"
else
    echo "✗ WARNING - tmux not found"
fi

# Test 4: Check if we're in tmux
echo -n "Test 4 - Inside tmux: "
if [ -n "$TMUX" ]; then
    echo "✓ PASSED"
else
    echo "✗ WARNING - Not inside tmux session"
fi

echo
echo "Basic tests completed!" 