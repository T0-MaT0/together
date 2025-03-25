

// 채팅방 열릴 때 호출
document.addEventListener("DOMContentLoaded", () => {
    loadMessageList();
    displayMessage(msg)
});


// 채팅 메시지 목록 불러오기
function loadMessageList() {
const roomNo = document.getElementById("chatRoom").dataset.roomNo;
const ul = document.getElementById("chatMessageList");
console.log('loadMessageList실행')
fetch(`/chatting/selectMessageList?chattingNo=${roomNo}&memberNo=${loginMemberNo}`)
    .then(res => res.json())
    .then(list => {
    ul.innerHTML = "";
    console.log(list)

    list.forEach(msg => {

        const li = document.createElement("li");
        const span = document.createElement("span");
        span.classList.add("chatDate");
        span.innerText = msg.sendTime;

        const p = document.createElement("p");
        p.classList.add("chat");
        p.innerHTML = msg.messageContent;

        if (msg.senderNo === loginMemberNo) {
        li.classList.add("my-chat");
        li.append(span, p);
        } else {
        li.classList.add("target-chat");

        const img = document.createElement("img");
        img.src = msg.senderProfile || "/resources/images/user.png";

        const div = document.createElement("div");
        const b = document.createElement("b");
        b.innerText = msg.senderNickname;
        const br = document.createElement("br");

        div.append(b, br, p, span);
        li.append(img, div);
        }

        ul.appendChild(li);
    });

    ul.scrollTop = ul.scrollHeight; 
    })
    .catch(err => console.error("메시지 목록 불러오기 실패", err));
}


// 받은 메시지 출력
function displayMessage(msg) {
  const ul = document.querySelector(".display-chatting");
  const li = document.createElement("li");
  const span = document.createElement("span");
  span.classList.add("chatDate");
  span.innerText = msg.sendTime;

  const p = document.createElement("p");
  p.classList.add("chat");
  p.innerHTML = msg.messageContent;

  if (msg.senderNo == loginMemberNo) {
    li.classList.add("my-chat");
    li.append(span, p);
  } else {
    li.classList.add("target-chat");

    const img = document.createElement("img");
    img.setAttribute("src", msg.senderProfile || "/resources/images/user.png");

    const div = document.createElement("div");
    const b = document.createElement("b");
    b.innerText = msg.senderNickname;

    div.append(b, document.createElement("br"), p, span);
    li.append(img, div);
  }

  ul.appendChild(li);
  ul.scrollTop = ul.scrollHeight;
}