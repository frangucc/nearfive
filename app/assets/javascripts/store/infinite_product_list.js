var InfiniteProductList = (function () {

  function ProductList(list) {
    var wind = $(window)
      , loading = false
      , loadingMessage = $('<div class="loading-next-page" />')
      , page = 1
      , lastPage = false
      , height = list.height()
      , offset = list.offset().top
      , threshold = calculateNextThreshold();

    // handle viewport scroll.
    // when into the threshold, start loading more products.
    wind.scroll(function () {
      // if under the threshold
      // if not still loading
      // if not hit the last page already
      if (wind.scrollTop() >= threshold && !loading && !lastPage) {
        getNextPage();
      }
    });

    /**
     * Calculates next scrollTop value that's
     * going to trigger a refresh.
     */
    function calculateNextThreshold() {
      height = list.height();
      return (height + offset) - 500;
    }

    /**
     * Handles loading states.
     * Shows/hides loading message and raises loading
     * flags.
     */
    function setLoading(state) {
      if (state === true) {
        loadingMessage.appendTo(list);
        loading = true;
      }
      else {
        loadingMessage.remove();
        loading = false;
      }
    }

    /**
     * Loads the next page of products.
     */
    function getNextPage() {
      setLoading(true);

      page++;
      $.ajax({
        beforeSend: function (xhr) {
          xhr.setRequestHeader('Accepts', '*/*');
        },
        url: document.location.href.split('?')[0] + '?page=' + page,
        complete: function (xhr) {
          // get <li>s from response.
          showNextPage( $(xhr.responseText).find('.' + list.attr('class')).find('li') );
          setLoading(false);
          threshold = calculateNextThreshold();
        }
      });
    }

    /**
     * Adds a collection of <li> items into the
     * list.
     */
    function showNextPage(li) {
      if (li.length > 0) {
        li.appendTo(list);
      }
      else {
        // show "no more results" message
        lastPage = true;
      }
    }

  }

  $.fn.infiniteProductList = function () {
    return $(this).each(function (index, object) {
      object = $(object);
      new ProductList(object);
    });
  }

}());