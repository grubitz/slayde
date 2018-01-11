var Slayde = {

  _moveCounter: 0,

  initialize: function() {
    this._initBoard();
    this._resetMoveCounter();
    $('#restart').on('click', this._restartButtonHandler.bind(this));
  },

  restart: function() {
    this._terminateBoard();
    this._initBoard();
    this._resetMoveCounter();
  },

  _initBoard: function() {
    $.getJSON('/games/new', this._buildTiles.bind(this));
  },

  _buildTiles: function(data) {
    $.each(data, this._buildTile.bind(this));
  },
  
  _buildTile: function(key, item) {
    var difficulty = 'easy';
    var tile = $('<div class="tile ' + difficulty + '" id="tile' + item + '" draggable="true">' +
      '<div class="content"><div class="game-grid">' +
      '<div class="table-cell">' + item + '</div></div></div></div>');
    var dropzone = $('<div class="dropzone"></div>');

    tile.on('dragstart', this._dragStartHandler.bind(this));

    dropzone.on('dragover', this._dragOverHandler.bind(this));
    dropzone.on('drop', this._dropHandler.bind(this));

    tile.appendTo(dropzone);
    dropzone.appendTo("#board");
  },

  _terminateBoard: function() {
    $('#board').empty();
  },

  _dropHandler: function(ev) {
    ev.preventDefault();

    this._incrementMoveCounter();
    this._swapTiles(ev);
    this._checkSolution();
  },

  _swapTiles: function(ev) {
    var dropped = $(ev.currentTarget).find('.tile');
    var dragged = $('#' + ev.originalEvent.dataTransfer.getData('id'));
    dropped.insertAfter(dragged);
    dragged.appendTo($(ev.currentTarget));
  },

  _dragStartHandler: function(ev) {
    ev.originalEvent.dataTransfer.setData('id', $(ev.currentTarget).attr('id'));
  },

  _dragOverHandler: function(ev) {
    ev.preventDefault();
  },

  _restartButtonHandler: function() {
    this.restart();
  },

  _checkSolution: function() {
    var order = [];
    $('.tile').each(function(key, tile) {
      order.push(tile.innerText);
    });
    $.post('/games/check', { solution: order }, function() {
      alert('You won!'); //todo
    });
  },

  _incrementMoveCounter: function() {
    this._moveCounter++;
    this._updateCounterElement();
  },

  _resetMoveCounter: function() {
    this._moveCounter = 0;
    this._updateCounterElement();
  },

  _updateCounterElement: function() {
    $('#counter').text(this._moveCounter);
  }
};

$(function() {
  Slayde.initialize();
});
