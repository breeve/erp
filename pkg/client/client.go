package client

import (
	"github.com/gdamore/tcell/v2"
	"github.com/rivo/tview"
)

func Run() {
	app := tview.NewApplication()

	textView := tview.NewTextView().
		SetDynamicColors(true).
		SetRegions(true).
		SetChangedFunc(func() {
			app.Draw()
		})
	textView.SetBorder(true)

	left := tview.NewTreeNode("")
	market := tview.NewTreeNode("market").
		SetSelectable(true)
	product := tview.NewTreeNode("product").
		SetSelectable(true)
	left.AddChild(market)
	left.AddChild(product)

	leftTree := tview.NewTreeView().
		SetRoot(left).
		SetCurrentNode(left).
		SetGraphics(false)

	leftTree.SetInputCapture(func(event *tcell.EventKey) *tcell.EventKey {
		if event.Key() == tcell.KeyEnter {
			leftTree.GetRoot().Walk(func(node, parent *tview.TreeNode) bool {
				node.SetColor(tview.Styles.PrimaryTextColor)
				return true
			})

			node := leftTree.GetCurrentNode()
			node.SetColor(tcell.ColorGreen)

			textView.SetText(node.GetText())

			return nil
		}

		return event
	})
	leftTree.SetBorder(true)

	flex := tview.NewFlex().
		AddItem(leftTree, 0, 1, true).
		AddItem(textView, 0, 11, false)

	if err := app.SetRoot(flex, true).Run(); err != nil {
		panic(err)
	}
}
