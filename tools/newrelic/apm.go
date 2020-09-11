package main

import (
	"github.com/newrelic/go-agent/v3/integrations/logcontext/nrlogrusplugin"
	_ "github.com/newrelic/go-agent/v3/integrations/nrmysql"
	"github.com/newrelic/go-agent/v3/newrelic"
	logAPI "github.com/sirupsen/logrus"
)

var nlog = logAPI.New()

func main() {
	// Requirement go.mod
	//    github.com/newrelic/go-agent/v3 v3.9.0
	//    github.com/newrelic/go-agent/v3/integrations/logcontext/nrlogrusplugin v1.0.0
	//    github.com/newrelic/go-agent/v3/integrations/nrmysql v1.2.0
	//    github.com/sirupsen/logrus v1.6.0

	// Newrelic
	app, err := newrelic.NewApplication(
		newrelic.ConfigAppName("isucon9-tutorial-by-tkngue"),
		newrelic.ConfigLicense("abc5b0a386e4eb1ae3244ca1865ecf5de545NRAL"),
		newrelic.ConfigDistributedTracerEnabled(true),
		func(c *newrelic.Config) {
			c.TransactionEvents.Enabled = true
			c.DatastoreTracer.SlowQuery.Enabled = true
		},
	)

	// Setup Newrelic's Logger
	file, err := os.OpenFile("/tmp/isucari.log", os.O_RDWR|os.O_CREATE|os.O_APPEND, 0666)
	nlog.SetFormatter(nrlogrusplugin.ContextFormatter{})
	nlog.SetOutput(file)

	// When you log anything, you should provide context.Context into logger.
	// log := nlog.WithContext(ctx)
	// log.Info("Awesome message")
	//
	// For slqx:
	dbx, err = sqlx.Open("nrmysql", dsn)

	// Setup Newrelic's MySQL Plugin
	// Setup Newrelic's Web Server Middleware
	nmw := func(handler http.Handler) http.Handler {
		if app == nil {
			return handler
		}
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			path := ""
			if r.URL != nil {
				path = r.URL.Path
			}

			txn := app.StartTransaction(r.Method + " " + path)

			defer txn.End()

			w = txn.SetWebResponse(w)
			txn.SetWebRequestHTTP(r)

			r = newrelic.RequestWithTransactionContext(r, txn)

			handler.ServeHTTP(w, r)
		})
	}
	mux.Use(nmw)

	// Setup Newrelic's HTTP Client
	http.DefaultClient.Transport = newrelic.NewRoundTripper(httpcache.NewMemoryCacheTransport())
}
