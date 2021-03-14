import express from "express";
import bodyParser from "body-parser";
import {postgraphile} from "postgraphile"
import {TagsFilePlugin} from "postgraphile/plugins";
import PostGraphileNestedMutations from "postgraphile-plugin-nested-mutations";
import * as dotenv from 'dotenv';

dotenv.config();

const {PORT, DB_HOST, POSTGRES_DB, DATABASE_URL, POSTGRES_USER, POSTGRES_PASSWORD, HOST, PG_PORT} = process.env

const host = HOST || "localhost";
const dbHost = DB_HOST ?? "localhost";
const port = parseInt(PORT ?? "8080");
const dbPort = parseInt(PG_PORT ?? "5432");

const app = express();

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended: false}))

app.use(postgraphile(
  DATABASE_URL ?? {
      database: POSTGRES_DB,
      user: POSTGRES_USER,
      password: POSTGRES_PASSWORD,
      host: dbHost,
      port: dbPort,
  }, "public", {
      watchPg: true,
      graphiql: true,
      enhanceGraphiql: true,
      graphileBuildOptions: {
          nestedMutationsSimpleFieldNames: true,
      },
      appendPlugins: [TagsFilePlugin, PostGraphileNestedMutations]
  }));

app.listen(port, () => {
    return console.log(`server is listening on ${port}`);
});
