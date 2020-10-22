
const title = document.querySelector("#title");

const CLICKED_CLASS = "clicked";

function handleClick() {
    // 아래 과정을 한 줄로 수행 할 수 있는 코드 
    title.classList.toggle(CLICKED_CLASS); 

    // const hasClass = title.classList.contains(CLICKED_CLASS);
    // if(!hasClass){
    //    title.classList.add(CLICKED_CLASS);
    // } else { 
    //     title.classList.remove(CLICKED_CLASS);
    // }}
}

function init(){    
    title.addEventListener("click", handleClick);
}

init();