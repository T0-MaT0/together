console.log("sideBarMain.js");

/* a태그 방지 */
const aTags = document.getElementsByTagName("a");
for (i = 0; i < aTags.length; i++) {
  aTags[i].addEventListener("click", e => {
    e.preventDefault();
  });
}

const sideBar = document.getElementById("sideBar");
const sideBarBox = document.getElementById("sidebar-menu-box");
const sideBarClose = document.getElementById("sideBar-close");



sideBarBox.addEventListener("click", function(e) {
  if (sideBar.classList.contains("active") || !sideBarClose.classList.contains("activate")) {
    return;
  }
  sideBar.classList.add("active");
  sideBarClose.classList.remove("activate");
});

sideBarClose.addEventListener("click", function(e) {
  e.stopPropagation();
  sideBar.classList.toggle("active");
  console.log("remove active");
  sideBarClose.classList.toggle("activate");
});





const menus = document.querySelectorAll("#CHAT .talkMenu>a");
const content = document.querySelectorAll("#CHAT .content");
const talkMenu = document.querySelectorAll("#CHAT .talkMenu");


for (let i = 0; i < content.length; i++) {
  menus[i].addEventListener("click", () => {
    if (talkMenu[i].classList.contains("unselect")) {
      for (let j = 0; j < talkMenu.length; j++) {
        if (i === j) {
          talkMenu[j].classList.remove("unselect");
          talkMenu[j].classList.add("select");
          content[j].classList.remove("hidden");
        } else {
          talkMenu[j].classList.remove("select");
          talkMenu[j].classList.add("unselect");
          content[j].classList.add("hidden");
        }
      }
    }
  });
}

flag = 0;

const classBody = document.getElementsByClassName("body");

document.getElementById("togglePage").addEventListener("click", e => {
  if (flag === 0) {
    e.target.setAttribute("src", "images/talk.svg");
    document.getElementById("title").innerText = '채팅';
    flag = 1;
  } else {
    e.target.setAttribute("src", "images/favorite-cart.svg");
    document.getElementById("title").innerText = '장바구니';
    flag = 0;
  }

  for (body of classBody) {
    body.classList.toggle("hidden");
  }
});


const minValue = document.getElementById("minValue");
const maxValue = document.getElementById("maxValue");

function transferValue( value) {
  if (value == 10) return '0';
  if (value == 20) return '10000';
  if (value == 30) return '100000';
  if (value == 40) return '999999~';
  
  
  

  let numString = value.toString();  
  let n = +numString[0];
  let a = +numString[1];

  console.log(n, a);
  return a*100*(10**(n));
}

class RangeSlider {
  constructor() {
    this.constants = {
      MAX_VALUE: this.getGlobalCssValue('--max-value'),
      MIN_VALUE: this.getGlobalCssValue('--min-value'),
      RANGE_STEP: this.getGlobalCssValue('--range-step'),
      HANDLE_SIZE: this.getGlobalCssValue('--handle-size'),
      get RANGE() {
        return this.MAX_VALUE - this.MIN_VALUE;
      }
    };

    this.elements = {
      progress: document.querySelector('.progress'),
      minRange: document.querySelector('.min-range'),
      maxRange: document.querySelector('.max-range'),
      handles: document.querySelectorAll('.handle')
    };

    this.elements.minRange.addEventListener("input", (e) => {
      let value = transferValue(+e.target.value);
      if (value == '999999~') {
        value = '990000';
      }
      minValue.innerText = value;
      this.setStartValue(+e.target.value);
    });

    this.elements.maxRange.addEventListener("input", (e) => {
      let value = transferValue(+e.target.value);
      if (value == 0) {
        value = 1000;
      }
      maxValue.innerText = value;
      this.setEndValue(+e.target.value);
    });
  }

  getGlobalCssValue(key) {
    const property = getComputedStyle(document.documentElement).getPropertyValue(key);
    return property ? parseFloat(property) : 0;
  }

  init({ min, max }) {
    const { MIN_VALUE, MAX_VALUE, RANGE_STEP } = this.constants;
    const { minRange, maxRange } = this.elements;

    minRange.min = maxRange.min = MIN_VALUE;
    minRange.max = maxRange.max = MAX_VALUE;
    minRange.step = maxRange.step = RANGE_STEP;
    
    // Initialize values
    minRange.value = min; 
    maxRange.value = max;
    
    this.setStartValue(min);
    this.setEndValue(max);
  }

  setHandlePos(range, handle) {
    const { MIN_VALUE, RANGE, HANDLE_SIZE } = this.constants;
    const percentage = (range.value - MIN_VALUE) / RANGE;
    const offset = HANDLE_SIZE / 2 - HANDLE_SIZE * percentage;
    const left = `calc(${percentage * 100}% + ${offset}px)`;
    handle.style.left = left;
  }

  setStartValue(v) {
    const { minRange, maxRange, progress, handles } = this.elements;
    if (v >= +maxRange.value) {
      v = +maxRange.value - this.constants.RANGE_STEP;
      minRange.value = v;
    }
    const value = this.getCurrStep(v) * this.constants.RANGE_STEP;
    progress.style.left = `${(value / this.constants.RANGE) * 100}%`;
    this.setHandlePos(minRange, handles[0]);
  }

  setEndValue(v) {
    const { minRange, maxRange, progress, handles } = this.elements;
    if (v <= +minRange.value) {
      v = +minRange.value + this.constants.RANGE_STEP;
      maxRange.value = v;
    }
    const value = this.getCurrStep(v) * this.constants.RANGE_STEP;
    progress.style.right = `${100 - (value / this.constants.RANGE) * 100}%`;
    this.setHandlePos(maxRange, handles[1]);
  }

  getCurrStep(v) {
    return (v - this.constants.MIN_VALUE) / this.constants.RANGE_STEP;
  }
}

const slider = new RangeSlider();
slider.init({ min: 10, max: 40 });