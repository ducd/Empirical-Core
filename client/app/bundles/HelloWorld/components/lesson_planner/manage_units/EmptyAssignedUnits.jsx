'use strict'

 import React from 'react'
 import UnitTabs from '../unit_tabs.jsx'

 export default React.createClass({

  handleClick() {
    window.location = '/teachers/classrooms/activity_planner#tab/assign-new-activity'
  },

   render: function () {
 		return (
        <div className="container">
          <div className="row empty-unit-manager">
            <div className="col-xs-7">
              <p>Welcome! This is where your assigned activity packs are stored, but it's empty at the moment.</p>
              <p>Let's add your first activity.</p>
            </div>
            <div className="col-xs-4">
              <button onClick={this.handleClick} className="button-green create-unit featured-button">Assign An Activity</button>
            </div>
          </div>
        </div>
    )}
})
