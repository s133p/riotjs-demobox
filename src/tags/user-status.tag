<user-status>
    <div class="o-container o-container--medium u-letter-box--large">

        <div class="c-card c-card--higher">
            <div class="c-card__item c-card__item--brand o-media">
                <img class="o-image" src={ avatar != "" ? avatar : "./images/placeholder/avatar.png" } />
                <div class="o-media__body">
                    <h2 class="c-heading">{ user }</h2>
                    <p class="c-paragraph"><v-date class='u-small'/><br/><v-time class='u-small'/></p>
                </div>
            </div>
            <div class="c-card__item" if={ repos == "" }>
                <div class="u-window-box--super">
                    <div class="u-center-block">
                        <div class="u-center-block__content">
                            <i class="fa fa-spinner fa-pulse fa-3x fa-fw"></i>
                            <span class="sr-only">Loading...</span>
                        </div>
                    </div>
                </div>
            </div>
            <div  if={ repos != "" }>
                <div class="c-card__item" each={ repo in repos.sort( repoDateSort ) }>
                    <div class="o-grid o-grid--center" onclick={ repoClicked }>
                        <div class="o-grid__cell">
                            <h4 class="c-heading"> { repo.full_name }</h4>
                        </div>
                        <div class="o-grid__cell o-grid__cell--shrink">
                            <v-date class="u-xsmall c-text--quiet" date={ repo.updated_at }/><br/>
                            <v-time class="u-xsmall c-text--quiet" date={ repo.updated_at }/>
                        </div>
                        <div class="o-grid__cell" style="text-align: center">
                            <p class="c-paragraph">{ repo.description }</p>
                        </div>
                        <div class="o-grid__cell o-grid__cell--width-20">
                            <div style="text-align: right">
                                <span class="c-badge c-badge--info c-badge--ghost">{ repo.language }</span>
                            </div>
                        </div>
                    </div>
                    <div class="o-grid o-grid--center o-grid--wrap" onclick={ repoClicked }>
                        <div data-is="grid-cell" width="100" each={ repo.commits } if={ repo.commits }>
                            <p class="c-paragraph">{ commit.message }</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- this script tag is optional -->
    <style>
        user-status img.o-image { height: 5em; width: auto; }
        user-status div.o-grid__cell--shrink { flex-basis: auto; flex-grow:0; order: -1;}
    </style>
    <script>
        'using strict';
        var tag = this;
        tag.repos = ""
        tag.avatar = ""
        tag.user = "s133p"
        tag.repoDateSort = repoDateSort;
        tag.repoClicked = repoClicked;
        tag.toLocalDate = toLocalDate;
        tag.toLocalTime = toLocalTime;
        var GitHub = require('github-api');

        // basic auth
        tag.gh = new GitHub({ });

        // console.log(gh);

        setTimeout(()=>{
            var me = tag.gh.getUser("s133p");
            me.listRepos({}, (err, returned) => {
                // console.log(returned)
                tag.repos = returned;
                tag.update();
            });

            me.getProfile((err, returned) => {
                // console.log(returned);
                tag.avatar = returned.avatar_url;
                tag.update();
            });
        }, 1500)

        // console.log(me);

        function repoDateSort(a, b){
            var aD = new Date(a.updated_at);
            var bD = new Date(b.updated_at);
            return aD < bD
        }
        function repoClicked(e){
            if( e.item.repo.commits ){ e.item.repo.commits = null; tag.update(); return; }
            var repo = gh.getRepo(e.item.repo.owner.login, e.item.repo.name);
            repo.listCommits({}, (err, returned) => { e.item.repo.commits = returned; tag.update() })
        }
        function toLocalDate(d){
            return (new Date(d)).toLocaleDateString()
        }
        function toLocalTime(d){
            return (new Date(d)).toLocaleTimeString()
        }

        // Markdowner

    </script>

</user-status>
