$(document).on('turbolinks:load', function(){
  $('#new_food').on('submit', function(e){
  e.preventDefault();
  var formdata = new FormData(this);
  var url = window.location.protocol + '//' + window.location.host + '/foods';

    $.ajax({
      url: url,
      type: "post",
      data: formdata,
      processData: false,
      contentType: false,
      dataType: 'json'
    })
//validation
    .done(function(new_food){
      console.log(new_food)

      $('#food-send-btn').prop('disabled', false);
      $("#new_food_validation p").remove();
    
      if (new_food.name == ""){
        $("#new_food_validation").prepend(`<p>食品名を入力してください。</p>`)
        $("#new_food_validation p").css({"color" : "red"});
      }
      if (new_food.hiragana_name.match(/^[\u3040-\u309F]+$/) == null){
        $("#new_food_validation").prepend(`<p>食品名（ひらがな）はひらがなで入力してください。</p>`)
        $("#new_food_validation p").css({"color" : "red"});
      }
      if (new_food.hiragana_name == ""){
        $("#new_food_validation").prepend(`<p>食品名（ひらがな）を入力してください。</p>`)
        $("#new_food_validation p").css({"color" : "red"});
      }
      if (new_food.calorie == null){
        $("#new_food_validation").prepend(`<p>カロリーを入力してください。</p>`)
        $("#new_food_validation p").css({"color" : "red"});
      }
      if (new_food.calorie <= 0){
        $("#new_food_validation").prepend(`<p>カロリーは半角数値で入力してください。</p>`)
        $("#new_food_validation p").css({"color" : "red"});
      }
      if (new_food.menu_category_id == null){
        $("#new_food_validation").prepend(`<p>詳細ジャンルを選択してください。</p>`)
        $("#new_food_validation p").css({"color" : "red"});
      }
      if (new_food.name != "" && new_food.hiragana_name.match(/^[\u3040-\u309F]+$/) != null &&  new_food.calorie > 0 && new_food.menu_category_id != null){
        var top_page_url = window.location.protocol + '//' + window.location.host + '/';    
        window.location.href = top_page_url;
      }
    })
  });
});