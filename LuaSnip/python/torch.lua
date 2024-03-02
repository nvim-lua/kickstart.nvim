local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- COMMON IMPORTS
    s({trig="itorch"},
      fmt(
        [[
          import torch
          from torch import nn
          from torch.utils.data import Dataset, DataLoader
        ]],
        {
        }
      ),
      {condition = line_begin}
    ),
    -- NETWORK MODEL TEMPLATE
    s({trig="model"},
      fmta(
        [[
          class FooNet(nn.Module):
              def __init__(self):
                  super(FooNet, self).__init__()
                  <>

              def forward(self, x):
                  <>
        ]],
        {
          i(1),
          i(2)
        }
      ),
      {condition = line_begin}
    ),
    -- CUSTOM DATASET TEMPLATE
    s({trig="dataset"},
      fmta(
        [[
          class FooDataset(Dataset):
              def __init__(self, ...):
                  <>
                  
              def __getitem__(self, index):
                  # Returns the (feature vector, label) tuple at index `index`
                  <>

              def __len__(self):
                  # Return number of instances in dataset
                  <>
        ]],
        {
          i(1),
          i(2),
          i(3)
        }
      ),
      {condition = line_begin}
    ),
    -- SGD OPTIMIZER
    s({trig="optim"},
      fmta(
        [[
          optim = torch.optim.SGD(model.parameters(), lr=<>)
        ]],
        {
          i(1),
        }
      ),
      {condition = line_begin}
    ),
    -- TRAINING LOOP TEMPLATE
    s({trig="train"},
      fmta(
        [[
          def train_loop(dataloader, model, loss_fn, optim):
              N = len(dataloader.dataset)

              # Loop over all minibatches in dataset
              for mb, (X, y) in enumerate(dataloader):
                  # Compute prediction and loss
                  pred = model(X)
                  loss = loss_fn(pred, y)

                  # Backpropagation
                  optimizer.zero_grad()
                  loss.backward()
                  optimizer.step()

                  # Log loss and number of instances trained
                  if mb % <> == 0:
                      loss, n = loss.item(), mb * len(X)
                      print("loss: {:.7f}  [{:5d}/{:5d}]".format(loss, n, N))
              
        ]],
        {
          i(1, "100"),
        }
      ),
      {condition = line_begin}
    ),
    -- TEST LOOP TEMPLATE
    s({trig="test"},
      fmta(
        [[
          def test_loop(dataloader, model, loss_fn):
              N = len(dataloader.dataset)
              num_batches = len(dataloader)
              test_loss = 0
              correct_preds = 0

              with torch.no_grad():
                  for X, y in dataloader:
                      pred = model(X)
                      test_loss += loss_fn(pred, y).item()
                      correct_preds += (pred.argmax(1) == y).type(torch.float).sum().item()

              test_loss /= num_batches
              print("Test Error: \n  Accuracy: {:.1f}%\n  Avg loss per minibatch: {:8f} \n".format((100*correct_preds/N), test_loss))
        ]],
        { }
      ),
      {condition = line_begin}
    ),
  }


