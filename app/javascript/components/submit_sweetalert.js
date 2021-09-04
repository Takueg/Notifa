import { initSweetalert } from '../plugins/init_sweetalert';

const initSubmitSweetalert = () => {
  initSweetalert('.search-saved-sweet-alert', {
    title: "Search saved!",
    text: "We will notify you when we find something.",
    icon: "success"
  }, (value) => {
    const form = document.querySelector("form");
    form.submit()
  });
};

export { initSubmitSweetalert };
