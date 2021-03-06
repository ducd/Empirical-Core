import React from 'react'
import { Router, Route, Link, hashHistory } from 'react-router'
import App from '../components/diagnostic/diagnostic_questionnaire/index.jsx'
import Stages from '../components/diagnostic/diagnostic_questionnaire/Stages.jsx'
import createHashHistory from 'history/lib/createHashHistory'
import SuccessView from '../components/diagnostic/diagnostic_questionnaire/SuccessView.jsx'
const hashhistory = createHashHistory({ queryKey: false })

export default React.createClass({



  render: function () {

      return (
        <Router history={hashHistory}>
          <Route path="/" component={App}>
            <Route path='success' component={SuccessView}/>
            <Route path='stage/:stage' component={Stages}/>
          </Route>
        </Router>
      );
  }
});
