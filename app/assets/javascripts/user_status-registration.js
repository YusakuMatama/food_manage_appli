$(document).on('turbolinks:load', function(){
  $('#profile-send-form').on('submit', function(e){
  e.preventDefault();
  var formdata = new FormData(this);
  var current_url = window.location.href;
  var profile_new_url = window.location.protocol + '//' + window.location.host + '/users/new';
  var profile_user_status_url = window.location.protocol + '//' + window.location.host + '/users/user_status';
  var profile_edit_url = window.location.href.replace("/edit", "");
  var url = "";
  var type = "";

  if (current_url == profile_new_url){
    url = profile_user_status_url
    type = "post"
  }
  else{
    url = profile_edit_url
    type = "patch"
  }

    $.ajax({
      url: url,
      type: type,
      data: formdata,
      processData: false,
      contentType: false,
      dataType: 'json'
    })
//validation
    .done(function(profile){
      console.log(profile.age)
      $('#profile-edit-btn').prop('disabled', false);
      $("#profile_validation p").remove();
    
      if (profile.name == ""){
        $("#profile_validation").prepend(`<p>ユーザー名を入力してください。</p>`)
        $("#profile_validation p").css({"color" : "red"});
      }
      if (profile.age == null){
        $("#profile_validation").prepend(`<p>年齢を入力してください。</p>`)
        $("#profile_validation p").css({"color" : "red"});
      }
      if (profile.age <= 0){
        $("#profile_validation").prepend(`<p>年齢を数字（半角）で入力してください。</p>`)
        $("#profile_validation p").css({"color" : "red"});
      }
      if (profile.gender == ""){
        $("#profile_validation").prepend(`<p>性別を入力してください。</p>`)
        $("#profile_validation p").css({"color" : "red"});
      }
      if (profile.name != "" && profile.age > 0 &&  profile.age != null && profile.gender != ""){
        var top_page_url = window.location.protocol + '//' + window.location.host + '/';    
        window.location.href = top_page_url;
      }
    })
  });
});