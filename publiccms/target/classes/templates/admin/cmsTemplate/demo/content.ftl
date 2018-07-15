{<@_content id=id>
    <#assign attribute=getContentAttribute(id)/>
    <@_category id=object.categoryId>
        <#assign category=object/>
    </@_category>
    id:"${object.id}",
    title:"${object.title?json_string}",
    url:"${object.url!}",
    description:"${(object.description?json_string)!}",
    categoryId:"${object.categoryId}",
    categoryTitle:"${category.name?json_string}",
    categoryUrl:"${category.url!}",
    editor:"${object.editor}",
    publishDate:"${object.publishDate}",
    text:"${(attribute.text?json_string)!}"
</@_content>
}