$(document).on('turbolinks:load', function(e){
  var select = document.getElementById('food_menu_category_id');

// 詳細ジャンルを選択したジャンルに合わせて変更
  function Detail_genre(genre){
    $("#food_menu_category_id").children().remove();
    var option = document.createElement('option');
    option.setAttribute('value', "");
    option.innerHTML = "-----";
    select.appendChild(option);

    for(var i = 0; i<genre.length; i++){
      var option = document.createElement('option');
      option.setAttribute('value', genre[i]);
      option.innerHTML = genre[i];
      select.appendChild(option);
    };
  }

// ユーザーがジャンル選択時にイベント発火
  $("#food_menu_id").on("change", function(){
    var user_select_category = $("#food_menu_id option:selected").val()

  // もしユーザーが和食を選んだら
    if (user_select_category == "和食"){
      Detail_genre(gon.japanese);
    }
  // もしユーザーが洋食を選んだら
    if (user_select_category == "洋食"){
      Detail_genre(gon.western);
    }
  // もしユーザーが中華を選んだら
    if (user_select_category == "中華"){
      Detail_genre(gon.chinese);
    }
  // もしユーザーがファーストフードを選んだら
    if (user_select_category == "ファーストフード"){
      Detail_genre(gon.fast);
    }
    // もしユーザーがドリンクを選んだら
    if (user_select_category == "ドリンク"){
      Detail_genre(gon.drinks);
    }
  // もしユーザーが各国料理を選んだら
    if (user_select_category == "各国料理"){
      Detail_genre(gon.other_country);
    }
    // もしユーザーがおつまみを選んだら
    if (user_select_category == "おつまみ"){
      Detail_genre(gon.otumamis);
    }
  // もしユーザーがスナック菓子を選んだら
    if (user_select_category == "スナック菓子"){
      Detail_genre(gon.snacks);
    }
  // もしユーザーがスイーツを選んだら
    if (user_select_category == "スイーツ"){
      Detail_genre(gon.sweets);
    }
  // もしユーザーが調理パンを選んだら
    if (user_select_category == "調理パン"){
      Detail_genre(gon.pans);
    }
  });
});
