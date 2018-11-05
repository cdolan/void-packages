import _ from "lodash"

document.addEventListener("DOMContentLoaded", e => {
  const $searchControl = document.querySelector("#search-control")
  const $searchInput = document.querySelector("#search")
  const $searchResults = document.querySelector("#search-results");

  function enableSpinner () {
    $searchControl.classList.add("is-loading")
  }

  function disableSpinner () {
    $searchControl.classList.remove("is-loading")
  }

  function clearResults () {
    while ($searchResults.firstChild)
      $searchResults.removeChild($searchResults.firstChild);
  }

  function displayResults (packages) {
    for (var pkg of packages) {
      let name = pkg.attributes.name

      let a = document.createElement("a")
      a.setAttribute("href", `/packages/${name}`)
      a.appendChild(document.createTextNode(name))

      let li = document.createElement("li")
      li.appendChild(a)

      $searchResults.appendChild(li)
    }
  }

  function searchEvent (e) {
    const query = e.target.value;

    if (query === "")
      return clearResults()

    enableSpinner()

    fetch(`/searches/new.json?q=${query}`)
      .then(res => res.json())
      .then(res => {
        disableSpinner()
        clearResults()
        displayResults(res.data)
      })
      .catch(err => console.log(err))
  }

  $searchInput.addEventListener("input", _.debounce(searchEvent, 500))
});
