const initToggleSearchForm = () => {
  const page1 = document.querySelector(".search-page-1");
  const page2 = document.querySelector(".search-page-2");
  const nextBtn = document.getElementById("next-form-btn")
  const backBtn = document.getElementById("back-form-btn")

  if (page1 && page2 && nextBtn) {
    page2.style.display = "none";
    nextBtn.addEventListener("click", () => {
      page1.style.display = "none";
      page2.style.display = "block";
    });

    backBtn.addEventListener("click", () => {
      page2.style.display = "none";
      page1.style.display = "block";
    });

  };
}

export { initToggleSearchForm };
