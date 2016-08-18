'use strict'

import React from 'react'
// import { Router, Route, Link, hashHistory } from 'react-router'
import ClassroomDropdown from '../../general_components/dropdown_selectors/classroom_dropdown.jsx'
import NavButtonGroup from './nav_button_group.jsx'

export default React.createClass({
  propTypes: {
    classrooms: React.PropTypes.array.isRequired,
    defaultClassId: React.PropTypes.number,
    dropdownCallback: React.PropTypes.function,
    buttonGroupCallback: React.PropTypes.function
  },

  render: function() {
    return (
      <div id='reports-navbar'>
        <h1>Activity Name</h1>
        <p>Activity Info</p>
        <div className='nav-elements'>
          <ClassroomDropdown classrooms={this.props.classrooms || [{name: 'Please Add a Classroom', id: null}]}
                             defaultClassId={this.props.defaultClassId}
                             callback={this.props.dropdownCallback}/>
          <NavButtonGroup clickCallback={this.buttonGroupCallback}/>
        </div>
        {this.props.children}
      </div>
    );
   }
 });