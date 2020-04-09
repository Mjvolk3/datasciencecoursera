#Week 2 quiz q1

library(httr)
#tutorial
oauth_endpoints("github")

myapp <- oauth_app("github",
                   key = "850756bf6a837e416bf7",
                   secret = "ec6f20c9fd319ec86f36b8cf50da8b85b350eb05"
)

github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
content(req)

#assignment
library(RJSONIO)
json1 = content(req)
json2 = jsonlite::fromJSON(toJSON(json1))
df <- data.frame(json2$name, json2$created_at)
print(df[df$json2.name == "datasharing",])