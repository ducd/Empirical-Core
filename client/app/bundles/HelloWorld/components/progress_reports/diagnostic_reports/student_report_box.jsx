import React from 'react'
import ScoreColor from '../../modules/score_color.js'
import ConceptResultTableRow from './concept_result_table_row.jsx'
import StudentReportHeader from './student_report_header.jsx'

export default React.createClass({

	header: function() {
		if (this.props.boxNumber === 1) {
			return (
				<tr className="student-report-headers">
					<td><div><span>Question</span></div></td>
					<td><div><span>Score</span></div></td>
					<td></td>
    		</tr>
			);
		}
	},

	concepts: function() {
		return this.props.questionData.concepts.map((concept) => (
			<ConceptResultTableRow concept={concept}/>
		));
	},

	directions: function(){
		const directions = this.props.questionData.directions;
		if (directions) {
			return (
				<tr className='directions'>
					<td>Directions</td>
					<td></td>
					<td><span>{directions}</span></td>
				</tr>
			)
		}
	},

	prompt: function(){
		const prompt = this.props.questionData.prompt;
		if (prompt) {
			return (
				<tr>
					<td>Prompt</td>
					<td></td>
					<td><span>{prompt}</span></td>
				</tr>
			)
		}
	},

	render: function() {
		const data = this.props.questionData;
		const header = this.props.boxNumber === 1 ? <StudentReportHeader boxNumber={this.props.boxNumber}/> : null;
		return (
			<div className='individual-activity-report'>
				<div className="student-report-box">
					<div className='student-report-table-and-index'>
							<div className='question-index'>{this.props.boxNumber}</div>
								<table>
									<tbody>
										{header}
										{this.directions()}
										{this.prompt()}
										<tr className={ScoreColor(data.score)}>
											<td>Response</td>
											<td></td>
											<td>{data.answer}</td>
										</tr>
										{this.concepts()}
	        				</tbody>
								</table>
				</div>
				</div>
			</div>
		);
	}

})
