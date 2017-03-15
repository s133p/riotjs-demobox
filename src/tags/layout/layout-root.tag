<layout-root>
    <virtual if={ layout && type }>
        <virtual each={ child in layout.layout }>
            <virtual if={ child.data }>
                <h2 class={ getClass(child.type, child.parameters) } if={getTagFromType(child.type) == 'h1'}>{ child.data }</h2>
                <p class={ getClass(child.type, child.parameters) } if={getTagFromType(child.type) == 'p'}>{ child.data }</p>
                <img class={ getClass(child.type, child.parameters) } if={getTagFromType(child.type) == 'img'} src={ child.data } ></img>
                <div class={ getClass(child.type, child.parameters) } if={getTagFromType(child.type) == 'div'}>{ child.data }</div>
            </virtual>
            <virtual if={ !child.data }>
                <virtual if={ getTagFromType(child.type) == 'div' }>
                        <div data-is="layout-root" layout={ child } class={ getClass(child.type, child.parameters) } />
                </virtual>
                <virtual if={ getTagFromType(child.type) == 'p' }>
                        <p data-is="layout-root" layout={ child } class={ getClass(child.type, child.parameters) } />
                </virtual>
                <virtual if={ getTagFromType(child.type) == 'h1' }>
                        <h2 data-is="layout-root" layout={ child } class={ getClass(child.type, child.parameters) } />
                </virtual>
            </virtual>
        </virtual>
    </virtual>

    <style>
        layout-root { display: block;}
    </style>
    <script>
        'using strict'
        var tag = this;
        tag.layout = opts.layout;
        tag.data = (tag.layout && tag.layout.data) ? tag.layout.data : ""
        tag.type = (tag.layout && tag.layout.type) ? tag.layout.type : "holder"
        tag.params = ( tag.layout && tag.layout.parameters ) ? tag.layout.parameters : {}
        tag.tagMap = {};
        tag.typeMap = {};
        tag.getClassFromType = (t) => { return (t && tag.typeMap[t]) || tag.typeMap["holder"] }
        tag.getTagFromType = (t) => { return (t && tag.tagMap[t]) || "div" }
        tag.getClassAdd = (p) => { return (p && p["class-add"]) ? p["class-add"] : "" }
        tag.getClass = (t, p) => { return  tag.getClassFromType(t) + " " + tag.getClassAdd(p)  }


        tag.typeMap["holder"] = "u-window-box--medium"
        tag.tagMap["holder"] = "div"

        tag.typeMap["image"] = "c-image"
        tag.tagMap["image"] = "img"

        tag.typeMap["header"] = "c-heading"
        tag.tagMap["header"] = "h1"

        tag.typeMap["paragraph"] = "c-paragrah"
        tag.tagMap["paragraph"] = "p"

        tag.typeMap["card"] = "c-card c-card--higher"
        tag.typeMap["card-item"] = "c-card__item"
        tag.typeMap["grid"] = "o-grid o-grid--small-full o-grid--medium-full o-grid--large-full"
        tag.typeMap["grid-cell"] = "o-grid__cell"
        tag.tagType = tag.getTagFromType(tag.type)

console.log(tag.getClass(tag.type, tag.params))
    </script>
</layout-root>
