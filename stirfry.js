function init() {
   //highlight the current day
   var now = new Date();
   var weekday = now.getDay();
   var tr = document.getElementById(weekday);
   tr.style.color = "red";

   //is there stir fry now?
   var isTime = 0;
   var hours = setup_hours();
   if (document.getElementById((weekday) + '.1').innerHTML == 'Yes') {
      var start = new Date(now.getFullYear(),now.getMonth(),now.getDate(),hours[weekday+1][1][0],hours[weekday+1][1][1]);
      var end = new Date(now.getFullYear(),now.getMonth(),now.getDate(),hours[weekday+1][1][2],hours[weekday+1][1][3]);
      if ((now - start >= 0) && (end - now >= 0)) {
         isTime = 1;
      }
   } if (document.getElementById((weekday) + '.2').innerHTML == 'Yes') {
      var start = new Date(now.getFullYear(),now.getMonth(),now.getDate(),hours[weekday+1][2][0],hours[weekday+1][2][1]);
      var end = new Date(now.getFullYear(),now.getMonth(),now.getDate(),hours[weekday+1][2][2],hours[weekday+1][2][3]);
      if ((now - start >= 0) && (end - now >= 0)) {
	 isTime = 1;
      }
   } 

   if (isTime == 0) {
      disp_section("Is there stir fry right now?","No.",0);
   } else if (isTime == 1) {
      disp_section("Is there stir fry right now?","You bet there is.",weekday);
   }
}

function disp_section(title,body,weekday) {
   if (weekday == 4) {
      var mar = document.createElement('marquee');
      mar.innerHTML = "IT'S STIR FRIDAY";
      mar.setAttribute('scrollamount','50');
      mar.style.fontSize = '1000%';
      mar.style.color = 'red';
      document.body.appendChild(mar);
      return;
   }
   var h1 = document.createElement('h1');
   h1.innerHTML = title;
   var p = document.createElement('p');
   p.innerHTML = body;
   h1.setAttribute('align','center');
   p.setAttribute('align','center');
   document.body.appendChild(h1);
   document.body.appendChild(p);
}

function setup_hours() {
   var hours = new Array(8);
   for (var i=0;i<8;i++) {
      hours[i] = new Array(3);
   }
   for (var i=2;i<7;i++) {
      hours[i][0] = new Array(7,  00, 10, 00);
      hours[i][1] = new Array(11, 00, 14, 30);
      hours[i][2] = new Array(16, 30, 19, 30);
   }
   hours[6][0] = new Array(7,  00, 10, 00);
   hours[6][1] = new Array(11, 00, 14, 30);
   hours[6][2] = new Array(16, 30, 19, 00);
   hours[7][0] = new Array(8,  00, 10, 54);
   hours[7][1] = new Array(11, 00, 14, 30);
   hours[7][2] = new Array(16, 30, 19, 00);
   hours[1][0] = new Array(11, 00, 14, 30);
   hours[1][1] = new Array(11, 00, 14, 30);
   hours[1][2] = new Array(16, 30, 19, 00);

   return hours;
}

window.onload = init;
