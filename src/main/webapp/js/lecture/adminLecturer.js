$(document).ready(function (){
  $('button').click(function(e){
    var str1 =$('textarea').val();
    console.log(str1);
//當遇到兩個空白轉換成兩個   註 : 這麼做是為了有其他考量 , 如果只是純文字資料沒有其他標籤符號 , 那轉換一個空白就可以了 .
    str2 = str1.replace(/  /g, "  ");

     //textarea換行轉成<br>
    str2 = str2.replace(/\n/g,"<br>");
		$('span').html(str2);
  });
});