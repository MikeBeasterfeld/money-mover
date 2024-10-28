## Questions

### What issues, if any, did you find with the existing code?

Errors from the backend were causing the UI lose all state and stop working.

This environment isn't set up in a way that I feel is productive to developers.  I tried for a while to use
the docker compose as is but the feedback cycle was talking too long, logs were hard to get to and didn't have
the information I needed, and restarting took too long and was a manual process.  I could have installed Node
locally and ran it that way but I tend to not install things I don't need on my personal computers.

The UI is using Mui but it seems to be half hearted or just starting to migrate to those components.  Anything
to do with typography (for example with headers) isn't implemented.

Types aren't used much and there isn't any runtime checking of API responses to the UI.  It looks like Express
has some type checking in place for requests using Joi.

A library like React Query could be used to simpify getting data from the API and would handle loading states,
retries, retry backoff, caching.

An ORM like Prisma could be used to ensure data is going into and coming back from the DB with the correct types.
It also adds a lot of nice features when dealing with joins.  When Prisma was first becoming popular didn't support
SQL joins and did some crazy two step queries but I think I heard that support for native joins has been added.

### What issues, if any, did you find with the request to add functionality?

The way the database is initialized doesn't make it easy or quick to make changes.  If this was in production
there would need to be a way to migrate the database to the new schema.  

### Would you modify the structure of this project if you were to start it over? If so, how?

At this size I think this structure is ok. It is something I would look at as the project grows and refactor if
the structure doesn't make sense.

There are arguments against monorepos for frontend and backend such as shared external dependencies but for 
sharing code & types between the backend and frontend a monorepo is a good way to do that without having to set
up and maintain a private npm server.

### Were there any pieces of this project that you were not able to complete that you'd like to mention?

All requested functionality is implemented.

### If you were to continue building this out, what would you like to add next?

Lots and lots of automated tests.

Create a development environment that removes the barriers and lets coders code.

Fully implement MUI, get a theme set up, and some way for developers and designers to test and document the use of
MUI and custom components (like Storybook).

Implement an ORM, preferrably one that includes a migration tool and has good integration with Typescript.
Also the update queries should be wrapped in a transaction to make sure there is no chance of an invalid
deposit or withdrawl coming through before the DB has finished the last one. You could also make the account
balance a field that is updated based off of a database trigger on the transactions table instead of updating
it in Express.

Look at adding a runtime validator like Zed or Joi to check the data response coming back from the API.
This is a maybe since the same team likely controls the FE and BE.

Add client side validation of inputs.  It is good to have the login on the server side as well which is
why I started there, but feedback can be given to the customer much quicker through the UI.

### If you have any other comments or info you'd like the reviewers to know, please add them below.

In the readme, the command says you will run `docker run build`.  I changed that to `docker compose build`.
It didn't make sense to me to try to get docker to run an image called 'build'.  Maybe this was part of the test?

This test seemed pretty straightforward when I glanced at it but it certainly became more of a challenge when
I started working on it. I'm not sure if that was intended but I did get to touch a lot of parts I didn't expect.
