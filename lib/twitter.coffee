TwitterView = require './twitter-view'
{CompositeDisposable} = require 'atom'

module.exports = Twitter =
  twitterView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @twitterView = new TwitterView(state.twitterViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @twitterView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'twitter:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @twitterView.destroy()

  serialize: ->
    twitterViewState: @twitterView.serialize()

  toggle: ->
    console.log 'Twitter was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
