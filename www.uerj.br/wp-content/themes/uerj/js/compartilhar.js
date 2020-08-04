/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


// var facebook_app_Id = '963297050459052'

//Facebook da Comuns
var facebook_app_Id = '533216673758528';

window.fbAsyncInit = function() {
    FB.init({
        appId      : facebook_app_Id,
        xfbml      : true,
        version    : 'v2.10'
    });
};

(function(d, s, id){
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) {return;}
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/pt_BR/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));          

document.getElementById('shareBtn').onclick = function() {
    FB.ui({
        method: 'share',
        display: 'popup',                
        href: window.location.href,
    }, function(response){});
}

