//验证
$(function(){
    $('.talen_two_f').formValidator({
                formCssClass: 'talen_two_f',
                nodeName: 'div',
                triggerMethod: 'submit',
                callback: function(){
                    return true;
                }
    });
});
// 针对时间补写验证
$(function(){            
    var $conBtn = $("form[name=anotherTime]"); 
    var errorDiv = $("<div class='val_start_error'>请选择开始时间</div>");
    var errorDiv1 = $("<div class='val_end_error'>请选择结束时间</div>");
    $conBtn.submit(function(){
        var startTime = ($("#start_date_y").val()) && ($("#start_date_m").val());
        if(startTime){
            var endTime = ($("#end_date_y").val()) && ($("#end_date_m").val());
            var error = $("#start_date_y").parent().parent().find(".val_start_error");
            if(error){
                error.hide();
            };                    
            if(endTime){
                var error1 =  $("#end_date_y").parent().parent().find(".val_end_error");
                if(error1){
                    error1.hide();
                }
            }else{
                $("#end_date_y").parent().after(errorDiv1);
                $("#start_date_y").parent().parent().find(".val_end_error").show();
                return false;
            }                 
        }else{
            $("#start_date_y").parent().after(errorDiv);
            $("#start_date_y").parent().parent().find(".val_start_error").show();
            return false;
        }
    });
});

//验证效果        
$(function(){
    var $tip = $(".place_holder_f"); 
    var $oInput = $("form").find("input");   
    $tip.each(function(){
        $(this).click(function(){
            var $oInput = $(this).parent().find("input");
            $(this).hide();
            $oInput.focus();
        });
    });
    $oInput.each(function(){
        var inputV = $(this).val();
        if(inputV != ''){
            $(this).next(".place_holder_f").hide(); 
        }
        $(this).focus(function(){
            $(this).next(".place_holder_f").hide();   
        });
        $(this).blur(function(){
            if($(this).val()){
                $(this).next(".place_holder_f").hide();
            }else{
                $(this).next(".place_holder_f").show();
            }
        });
    });
});
