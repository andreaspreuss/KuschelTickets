{include file="header.tpl" title="FAQ"}
<div class="ui container grid stackable">
    <div class="four wide column">
        <div class="ui styled accordion">
        <div class="plainItem">
            <div class="ui category search faqsearchField field">
                <div class="ui icon input faqsearch">
                    <input class="prompt" type="text" placeholder="Suchen..">
                </div>
                <div class="results"></div>
            </div>
        </div>
        {foreach from=$categories item="category"}
        <div class="title">
            <i class="dropdown icon"></i>
            {$category->name}
        </div>
        <div class="content">
            <p>
                <ul class="ui list">
                    {foreach from=$category->getFAQs() item="faq"}
                        <a class="item" id="faq{$faq->faqID}" href="#{$faq->faqID}">{$faq->question}</a>
                    {foreachelse}
                        <i class="item">In dieser Kategorie sind keine FAQs eingetragen.</i>
                    {/foreach}
                </ul>
            </p>
        </div>
        {foreachelse}
            <div class="content">
                <i>Es wurde noch keine FAQ Kategorie erstellt.</i>
            </div>
        {/foreach}
        </div>
    </div>
    <div class="twelve wide column">
        <div class="ui segment">
            <h2 class="ui header" id="faqtitle">
                FAQ
            </h2>
            <p id="faqanswer">
                Um einen Eintrag anzusehen, nutze bitte die Navigation.
            </p>
        </div>
    </div>
</div>
<script>
$(document).ready(function(){
    $('.ui.accordion').accordion();
});

var searchContent = [
    {foreach from=$categories item="category"}
        {foreach from=$category->getFAQs() item="faq"}
            { category: "{$category->name}", title: "{$faq->question}", url: "#{$faq->faqID}"},
        {/foreach}
    {/foreach}
];

$(".ui.faqsearchField").search({
    type: 'category',
    source: searchContent,
    fullTextSearch: false,
    showNoResults: false
});

window.onhashchange = function() {
    var hash = window.location.hash.substr(1);
    var elem = document.getElementById("faq" + hash);
    if(elem) {
        if(!isNaN(hash)) {
            var answer = ajax.call(21, hash);
            if(answer['success']) {
                answer = answer['message'];
                var question = elem.innerHTML;
                document.getElementById("faqtitle").innerHTML = question;
                document.getElementById("faqanswer").innerHTML = answer;
            } else {
                document.getElementById("faqtitle").innerHTML = "Fehler";
                document.getElementById("faqanswer").innerHTML = "<p>Es ist ein Fehler bei der AJAX Anfrage aufgetreten.</p>";
            }
        }
    }
}
window.onhashchange();
</script>
{include file="footer.tpl"}