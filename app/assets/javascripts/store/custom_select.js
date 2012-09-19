var CustomSelect = (function () {

  function Select(input) {
    var select = $('<a href="#" />')
      , display = $('<span />')
      , handle = $('<span />')
      , optionList = $('<ul />');

    // add options to option list
    input.find('option').each(function (index, option) {
      option = $(option);
      $('<li />')
        .data('value', option.val())
        .html(option.html())
        .appendTo(optionList);
    });

    // event handlers.
    optionList.find('li')
      .click(function () {
        hideOptionList();
        setSelection(this);
      });

    select
      .click(function () {
        return false;
      });

    handle.add(display)
      .click(function () {
        toggleOptionList();
        return false;
      })

    // find the <li> item that has the original select's
    // value.
    optionList.find('li')
      .filter(function () {
        return $(this).data('value').toString() === input.val();
      })
      .click();

    // hide, add class and append everything.
    input
      .hide();

    display
      .addClass('custom-select-display');
    handle
      .addClass('custom-select-handle');
    optionList
      .addClass('custom-select-optionlist')
      .hide();

    select
      .addClass('custom-select')
      .attr('tab-index', input.attr('tab-index'))
      .append(display, handle, optionList)
      .insertAfter(input);

    /**
     * Sets the value in the original select
     * and replicates into the custom one.
     */
    function setSelection(li) {
      li = $(li);
      input
        .val(li.data('value'));
      display
        .html(li.html());
      optionList.find('li')
        .removeClass('selected');
      li
        .addClass('selected');
    }

    /**
     * Hides if visible and shows if hidden.
     */
    function toggleOptionList() {
      if (optionList.is(':visible')) {
        hideOptionList();
      }
      else {
        showOptionList();
      }
    }

    /**
     * Shows the option list.
     */
    function showOptionList() {
      optionList.show();
      select.addClass('option-list-open');
    }

    /**
     * Hides the option list.
     */
    function hideOptionList() {
      optionList.hide();
      select.removeClass('option-list-open');
    }

    /**
     * Selects the <li> item below the one
     * currently selected.
     */
    function selectNext() {
      var selected = optionList.find('li.selected');
      if (selected.next().length !== 0) {
        setSelection(selected.next());
      }
    }

    /**
     * Selects the <li> item above the one
     * currently selected.
     */
    function selectPrev() {
      var selected = optionList.find('li.selected');
      if (selected.prev().length !== 0) {
        setSelection(selected.prev());
      }
    }

    /**
     * Takes control of the up and down keys
     * to use it to select options in the select.
     */
    function catchUpDownKeys() {
      $(window).bind('keydown.custom-select', function (e) {
        if (e.keyCode === 40 || e.keyCode === 39) {
          selectNext();
          return false;
        }
        else if (e.keyCode === 37 || e.keyCode === 38) {
          selectPrev();
          return false;
        }
        else if (e.keyCode === 32) {
          toggleOptionList();
          return false;
        }
        else if (e.keyCode === 13) {
          hideOptionList();
          return false;
        }
      })
    }

    /**
     * Gives control of up and down keys back
     * to the window.
     */
    function releaseUpDownKeys() {
      $(window).unbind('keypress.custom-select');
    }
  }

  $.fn.customSelect = function () {
    return $(this).each(function (index, object) {
      object = $(object);
      new Select(object);
    });
  };

}());