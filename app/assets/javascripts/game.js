var Slayde = {

  initialize: function() {
    this._initBoard();
    $('#restart').on('click', this._restartButtonHandler.bind(this));
  },

  restart: function() {
    this._terminateBoard();
    this._initBoard();
  },

  _initBoard: function() {
    $.getJSON('/games/new', this._buildTiles.bind(this));
  },

  _buildTiles: function(data) {
    $.each(data, this._buildTile.bind(this));
  },
  
  _buildTile: function(key, item) {
    var tile = $('<div class="tile" id="tile' + item + '" draggable="true">' + item + '</div>');
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
      alert('Congrats');
    });
  }
};

$(function() {
  Slayde.initialize();
});
