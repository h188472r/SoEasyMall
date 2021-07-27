//輪播區
let upcomingSlideNum=0;
let upcomingSlideCount=$(".upcomingLecture_li").length;
let upcomingLastIndex=upcomingSlideCount-1;

    
$(".upcomingLecture_dot_li").eq(0).css("background-color","darkgreen");
$(".upcomingLecture_dot_li").mouseenter(function(){
    upcomingSlideNum=$(".upcomingLecture_dot_li").index($(this));
    upcomingLecture_show();
})

function upcomingLecture_show(){
    $(".upcomingLecture_dot_li").eq(upcomingSlideNum).css("background-color","darkgreen")
    .siblings().css("background-color","transparent");

    let slidemove=0-800*upcomingSlideNum;
    $(".upcoming_slides").css("left",slidemove);
}

$("#upcomingLecture_prevSlide").click(function(){
    upcomingSlideNum--;
    if(upcomingSlideNum<0)upcomingSlideNum=upcomingLastIndex;
    upcomingLecture_show();
})

$("#upcomingLecture_nextSlide").click(function(){
    upcomingSlideNum++;
    if(upcomingSlideNum>upcomingLastIndex)upcomingSlideNum=0;
    upcomingLecture_show();
})

let s1 = setInterval(function () {
    if (upcomingSlideNum == upcomingSlideCount)
        upcomingSlideNum = 0;
    upcomingLecture_show();
    upcomingSlideNum++;
}, 5000);      

$(".wrapper").mouseenter(function () {
    clearInterval(s1);
    })

$(".wrapper").mouseleave(function () {
    s1 = setInterval(function () {
    if (upcomingSlideNum == upcomingSlideCount)
        upcomingSlideNum = 0;
    upcomingLecture_show();
    upcomingSlideNum++;
   }, 5000);     
   })