const initLoadChannelIcons = () => {
  const emailBtn = document.querySelector("fieldset.form-group.radio_buttons.required.search_channel > div > div:nth-child(2) > label");
  const smsBtn = document.querySelector("fieldset.form-group.radio_buttons.required.search_channel > div > div:nth-child(3) > label");
  const slackBtn = document.querySelector("fieldset.form-group.radio_buttons.required.search_channel > div > div:nth-child(4) > label");
  emailBtn.innerHTML = "<i class='ti ti-mail'></i>";
  smsBtn.innerHTML = "<i class='ti ti-device-mobile-message'></i>";
  slackBtn.innerHTML = "<i class='ti ti-brand-slack'></i>";
  console.log(slackBtn.innerHTML);
};

export { initLoadChannelIcons };
