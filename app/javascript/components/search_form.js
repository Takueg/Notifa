const initToggleSearchForm = () => {
  const page1 = document.querySelector(".search-page-1");
  const page2 = document.querySelector(".search-page-2");
  const nextBtn = document.getElementById("next-form-btn")

  if (page1 && page2 && nextBtn) {
    page2.style.display = "none";
    nextBtn.addEventListener("click", (event) => {
      page1.style.display = "none";
      page2.style.display = "block";
    });
  };

}

console.log(initToggleSearchForm())

export { initToggleSearchForm };
