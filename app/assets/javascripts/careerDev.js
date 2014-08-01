//雇主反馈
$(function(){

	//左侧hover效果
	var $recomendLi = $(".recomend_area_f").find("ul").filter(":first").children();
		$recomendLi.hover(function(){
			$(this).css("background-color", "#f9f8f4");
		},function(){
			$(this).css("background-color", "#fff");
		});
    //最新活动hover效果

    var $actLi = $(".plan_company li");
    $actLi.hover(function(){
        var hoverSrc = $(".plan_company").attr("data-src");
        $(this).find("img").attr("src",hoverSrc);
    },function(){
        var linkSrc = $(this).find("a").attr("rel-src");
        $(this).find("img").attr("src",linkSrc);
    });
	//右侧雇主反馈
	$(".feed_con_f").each(function(){
		//截字
		var articleText = $(this).find("p").html();
		if(articleText.length > 42){
			var newText = articleText.slice(0,42);
			newText += "...";
			$(this).find("p").html(newText);
		}
		//折叠
        var $showCon = $(this).find(".fd_show_more"),
			$articP = $(this).find("p");
			$showCon.on("click",function(){
                if($showCon.html() == "展开"){
                    $articP.css({
                    "overflow": "visible",
                    "height": "auto"
                    });
                    $articP.html(articleText);
                    $showCon.html("收起");
                }else{
                    $articP.css({
                        "overflow": "hidden",
                        "height": "47px"
                    });
                    $articP.html(newText);
                    $showCon.html("展开");
                };
			});
	});
});


//日历
$(function(){
	var printDate = {
                actList:function(element){                 
                },
                monthData:function(dom,y,m){
                    var $oTip = $('.calendar_tip', dom.parentNode);
                    var tipFlag = false;
                    $oTip.hide().hover(function() {
                        tipFlag = true;
                    }, function() {
                        tipFlag = false;
                        $oTip.hide();
                    });
                    $.ajax({
                        type: "get",
                        url: "calendar.json",
                        dataType: "json",
                        success: function(data){
                            var activeDays = [],
                                activeTitle = [],
                                activeMonth = [],
                                activeYear = [],
                                activeUrl = [];
                            for(var i=0; i<data.length; i++){
                                activeYear[i] = data[i].date.split("-")[0];
                                activeMonth[i] = data[i].date.split("-")[1];
                                activeDays[i] = data[i].date.split("-")[2];
                                activeTitle[i] = data[i].title;
                                activeUrl[i] = data[i].url;
                            }
                            var domLi = $(dom).children().not($(".gray"));
                            domLi.each(function(e){
                                var dataDate = $(this).attr("data-date").split("-")[2],
                                    dataYear = $(this).attr("data-date").split("-")[0],
                                    dataMonth = $(this).attr("data-date").split("-")[1];
                                    
                                for(var i=0; i<activeDays.length; i++){
                                    if(activeDays[i] == dataDate && activeYear[i] == dataYear && activeMonth[i]== dataMonth){
                                        $(this).addClass("current_f");
                                        $(this).mouseover((function(index){
                                            return function(e){
                                                var pos = $(this).offset(),
                                                    tLength = activeTitle[index].length,
                                                    links = '';
                                                tipFlag = true;
                                                if(tLength>1){
                                                    for(var k=0; k<tLength; k++){
                                                        links += "<a href="+activeUrl[index][k].toString()+">"+activeTitle[index][k].toString() +"</br>"+"</a>";
                                                    }
                                                    $oTip.html(links).css({
                                                        top: pos.top - 10,
                                                        left: pos.left + 20
                                                    }).show();   
                                                }else{
                                                    $oTip.html("<a href="+activeUrl[index]+">"+activeTitle[index]+"</a>").css({
                                                        top: pos.top - 10,
                                                        left: pos.left + 20
                                                    }).show();
                                                }    
                                            }                                            
                                        })(i));
                                        
                                        $(this).mouseleave(function(){
                                            tipFlag = false;
                                            setTimeout(function() {
                                                if(!tipFlag) {
                                                    $oTip.hide();
                                                }
                                            }, 200);
                                        });
                                    }
                                }                                                            
                            });
                        }
                    });
                }
            }

    var myDatePicker = new actCalendar({
            "eventDay":printDate.actList,
            "box":"#calendar2 .calendar",
            "callback": printDate.monthData
        });

});

