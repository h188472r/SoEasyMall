//輪播區
let slideNum=0;
let slideCount=$(".ongoingLecture_li").length;
let lastIndex=slideCount-1;

    
$(".ongoingLecture_dot_li").eq(0).css("background-color","darkgreen");
$(".ongoingLecture_dot_li").mouseenter(function(){
    slideNum=$(".ongoingLecture_dot_li").index($(this));
    ongoingLecture_show();
})

function ongoingLecture_show(){
    $(".ongoingLecture_dot_li").eq(slideNum).css("background-color","darkgreen")
    .siblings().css("background-color","transparent");

    let slidemove=0-800*slideNum;
    $(".ongoing_slides").css("left",slidemove);
}

$("#ongoingLecture_prevSlide").click(function(){
    slideNum--;
    if(slideNum<0)slideNum=lastIndex;
    ongoingLecture_show();
})

$("#ongoingLecture_nextSlide").click(function(){
    slideNum++;
    if(slideNum>lastIndex)slideNum=0;
    ongoingLecture_show();
})

let s = setInterval(function () {
    if (slideNum == slideCount)
        slideNum = 0;
    ongoingLecture_show();
    slideNum++;
}, 5000);      

$(".wrapper").mouseenter(function () {
    clearInterval(s);
    })

$(".wrapper").mouseleave(function () {
    s = setInterval(function () {
    if (slideNum == slideCount)
        slideNum = 0;
    ongoingLecture_show();
    slideNum++;
    }, 5000);    
   })